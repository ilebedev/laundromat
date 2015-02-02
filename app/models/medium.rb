class Medium < ActiveRecord::Base
  # the database stores:
  # t.string :image_url
  # t.string :title
  # t.integer :category
  # t.timestamps

  has_many :streams, dependent: :destroy

  enum category: [ :film, :show ]

  after_create :populate_streams

  def populate_streams
    Dir.chdir(Rails.public_path)

    path = "linked_media/" + category + "/" + title.gsub(/( )/, '_').downcase

    case category
    when "film"
      stream = folder_to_stream(path, title)
      self.image_url = stream.image_url
      streams = [ stream ]
    when "show"
      # episodes are sub-folders named by "s<%= season %>e<%= episode %>_<%= title %>"
      folders = Dir.glob( path + '/*' ).select{ |f| File.directory? f }
      streams = folders.map { |f| folder_to_stream( f, File.basename(f).titleize) }
    else
      raise 'Unknown media category : "' + category + '"'
    end

    # Now save all these streams
    streams.each do |s|
      raise "Couldn't save a stream :(" unless s.save
    end

    save
  end

  def folder_to_stream(path, title)
    # /:type/:title
    videos = Dir.glob(path + '/*.mp4')
    subtitles = Dir.glob(path + '/*.vtt')

    stream = Stream.new
    stream.title = title
    stream.description = "No description yet :("
    stream.imdb_link = nil
    stream.date_produced =  DateTime.new(1900)
    stream.image_url = path + '/image.jpg'
    stream.video_urls = videos.to_json
    stream.subtitle_urls = subtitles.to_json

    stream.medium = self

    return stream
  end

  validates :title, presence: true
  #validates :image_url, presence: true
  validates :category, presence: true
end
