class Request < ActiveRecord::Base
  # the database stores:
  # string title
  # integer category
  # text description
  # string link
  # integer votes
  # datetime created_at
  # datetime updated_at

  validates :request, presence: true

end
