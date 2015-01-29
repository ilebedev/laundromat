class Medium < ActiveRecord::Base
  # the database stores:
  # t.string :image_url
  # t.string :title
  # t.integer :type
  # t.timestamps

  has_many :streams

  enum type: [ :film, :show ]

  validates :title, presence: true
  validates :image_url, presence: true
  validates :type, presence: true
end
