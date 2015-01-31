class Stream < ActiveRecord::Base
  # the database stores:
  # t.string :title
  # t.string :description
  # t.string :imdb_ink
  # t.datetime :date_produced
  # t.datetime :created_on
  # t.string :urls
  # t.references :media, polymorphic: true, index: true
  # t.timestamps

  def self.orphans
    []
  end

  belongs_to :medium

  validates :title, presence: true
  validates :date_produced, presence: true
  validates :urls, presence: true
end
