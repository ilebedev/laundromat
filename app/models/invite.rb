class Invite < ActiveRecord::Base
  # the database stores:
  # string token
  # datetime expiration_date
  # datetime created_at
  # datetime updated_at
   
  belongs_to :user
     
  before_create :generate_token
  
  def generate_token
	self.token = SecureRandom.uuid.gsub("-","")
  end
end
