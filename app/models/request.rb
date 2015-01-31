class Request < ActiveRecord::Base
  # the database stores:
  # string title
  # integer category
  # text description
  # string link
  # integer votes
  # datetime created_at
  # datetime updated_at
  
  enum category: [:film, :show]
  
  validates :title, presence: true
  validates :category, presence: true
  
  before_create :set_one_vote

  def set_one_vote
    self.votes ||= 1
  end
end
