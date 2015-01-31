class Medium < ActiveRecord::Base
  # the database stores:
  # t.string :image_url
  # t.string :title
  # t.integer :category
  # t.timestamps

  has_many :streams

  enum category: [ :film, :show ]

  validates :title, presence: true
  validates :image_url, presence: true
  validates :category, presence: true
end
