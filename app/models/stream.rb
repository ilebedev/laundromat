class Stream < ActiveRecord::Base
  # the database stores:
  # t.string :title
  # t.string :description
  # t.string :imdb_link
  # t.datetime :date_produced
  # t.string :image_url
  # t.string :video_urls
  # t.string :subtitle_urls
  # t.belongs_to :medium
  # t.timestamps

  def self.orphans
    Stream.select { |s| s.medium.nil? }
  end

  belongs_to :medium

  validates :title, presence: true, uniqueness: { scope: :medium }
  validates :medium, presence: true
  validates :image_url, presence: true
end
