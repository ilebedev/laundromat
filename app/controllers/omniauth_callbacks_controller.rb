class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # Devise omniauth callbacks
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        #need to implement this in my model
        @user = User.from_omniauth(request.env["omniauth.auth"])
        if @user.persisted?
          sign_in_and_redirect @user
          set_flash_message(:notice,
                            :success,
                            :kind => "#{provider}".capitalize) if is_navigational_format?
        else
          session["devise.omniauth.data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end

  [ :facebook, :google_oauth2 ].each do |provider|
    provides_callback_for provider
  end
end
