class Invite < ActiveRecord::Base
  # the database stores:
  # string token
  # string memo
  # belongs_to user

  belongs_to :user

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.uuid.gsub("-","")
  end
end
