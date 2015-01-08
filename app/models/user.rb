class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable,
         :omniauth_providers => [ :facebook,
                                  :google_oauth2 ]

  def self.from_omniauth(auth)
    # todo - update email maybe?
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.first_name = auth.info.first_name
      user.image = auth.info.image
      user.email = auth.info.email
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.omniauth.data"] &&
                session["devise.omniauth.data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.image = data["image"] if user.image.blank?
        user.first_name data["first_name"] if user.first_name.blank?
      end
    end
  end
end
