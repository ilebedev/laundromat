class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # NOTE: Public actions, no authorization
  # NOTE: development-only actions to log in via links
  before_filter :restrict_to_development, only: [:development_auth, :development_user_params]

  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        #need to implement this in my model
        @user = User.from_omniauth(request.env["omniauth.auth"])
        handle_sign_in(@user, "#{provider}")
      end
    }
  end

  [ :facebook, :google_oauth2 ].each do |provider|
    provides_callback_for provider
  end

  # development-only method for authentication via a link
  def development_auth
    @user = User.from_params(development_user_params)
    handle_sign_in(@user, "development")
  end

  protected
    def development_user_params
      params.permit(:provider, :uid, :first_name, :image, :role, :email)
    end

    def handle_sign_in(user, provider)
      if user.persisted?
        sign_in_and_redirect user
          set_flash_message(:notice,
                            :success,
                            :kind => provider.capitalize) if is_navigational_format?
      else
        session["devise.omniauth.data"] = request.env["omniauth.auth"]
        byebug
        redirect_to new_user_registration_url
      end
    end
end
