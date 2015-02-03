class Medium < ActiveRecord::Base
  # the database stores:
  # t.string :image_url
  # t.string :title
  # t.integer :category
  # t.timestamps

  has_many :streams, dependent: :destroy

  enum category: [ :film, :show ]

  before_save :fix_title
  after_create :populate_streams

  def fix_title
    self.title = self.title.titleize
  end

  def populate_streams
    Dir.chdir(Rails.public_path)

    path = "linked_media/" + category + "/" + sanitize_folder_name(title).downcase

    manifest = YAML.load_file(path + "/manifest.yml") rescue nil

    unless manifest
      self.errors.add(:base, 'could not read a YAML manifest at "' + path + '/manifest.yml"! Make sure the folder exists and has a well-formatted manifest.')
      raise
    end

    unless manifest["title"].titleize == self.title
      self.errors.add(:base, "Title does not match title in YML")
      raise
    end

    unless manifest["streams"] and manifest["image_url"]
      self.errors.add(:base, 'manifest does not have a "streams" and/or "image_url" key.')
      raise
    end

    unless manifest["streams"].map{ |k,v| v["title"] }.compact.uniq.length == manifest["streams"].length
      self.errors.add(:base, 'each stream in the manifest must have a unique title key')
    end

    self.image_url = path + '/' + manifest["image_url"]

    unless save
      self.errors.add(:base, "couldn't save infomration loaded from manifest")
      raise
    end

    manifest["streams"].each do | sub_folder, stream_manifest |
      #find or create by media_id and title

      if sub_folder == "."
        stream_path = path
      else
        stream_path = path + '/' + sub_folder
      end

      Stream.where(medium: self, title: stream_manifest["title"]).first_or_create do |stream|
        stream.image_url = stream_path + '/' + stream_manifest["image_url"]
        stream.description = stream_manifest["description"]
        stream.imdb_link = stream_manifest["imdb_link"]
        stream.date_produced = stream_manifest["date_produced"]
        stream.video_urls = [*stream_manifest["videos"]].map{ |v| stream_path + '/' + v + '.mp4' }.to_json
        stream.subtitle_urls = [*stream_manifest["subtitles"]].map{ |s| stream_path + '/' + s + '.vtt' }.to_json
        stream.medium = self

        unless stream.save
          self.errors.add(:base, 'stream "' + stream.title + '" : ' + stream.errors.full_messages.to_sentence)
          raise
        end
      end
    end
  end

private
  def sanitize_folder_name(name)
    # strip most things
    name.gsub(/\s+/, '_').gsub(/[^_0-9A-Za-z.\-]/, '')
  end

  validates :title, presence: true
  #validates :image_url, presence: true
  validates :category, presence: true
end
