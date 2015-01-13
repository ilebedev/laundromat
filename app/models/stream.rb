class Stream < ActiveRecord::Base
  # the database stores:
  # string title
  # text description
  # datetime created_at
  # datetime updated_at
  
  enum category: [:film, :tv, :other]
  
  validates :title, presence: true
  validates :category, presence: true
end
