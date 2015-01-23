class User < ActiveRecord::Base
  # the database stores:
  # string first_name
  # string image
  # string email
  # string provider (for oauth)
  # string uid (for oauth)
  # datetime last_seen

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable,
         :omniauth_providers => [ :facebook,
                                  :google_oauth2 ]

  # Roles for authorization (defaults to lowest privilege)
  ROLES = [:guest, :user, :admin] # NOTE: order matters! Enum value grows left to right.
  enum role: ROLES
  after_initialize :set_default_role, if: :new_record?
  def set_default_role
    p '--------------------------------'
    p User.count
    if User.count_by_sql("select count(*) from users") == 0
      self.role = :admin
    else
      self.role ||= :guest
    end
  end

  def self.from_omniauth(auth)
    # todo - update email maybe?
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.first_name = auth.info.first_name
      user.image = auth.info.image
      user.email = auth.info.email
    end
  end

  if Rails.env.development?
    def self.from_params(params)
      # todo - update email maybe?
      # todo - dry this up
      where(provider: params[:provider], uid: params[:uid]).first_or_create do |user|
        user.first_name = params[:first_name]
        user.image = params[:image]
        user.email = params[:email]
        user.role = params[:role]
      end
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
