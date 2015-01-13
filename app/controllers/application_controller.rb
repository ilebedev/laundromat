class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Require authentication in all places except where explicitly omitted
  # to omit, add #skip_before_filter :authenticate_and_authorize_user!, :only => [:index]
  config.to_prepare do
    Devise::SessionsController.skip_before_filter :authenticate_and_authorize_user
  end
  before_filter :authenticate_and_authorize_user

  #TODO: do we need this?
  #def new_session_path(scope)
  #  new_user_session_path
  #end

  protected
    def restrict_to_development
      head(:bad_request) unless Rails.env.development?
    end
	
  def authorize(roles)
    if not user_signed_in?
      flash[:alert] = "Sorry, bro, you need to log in to do that :("
      redirect_to root_url
      return false
    end

    # check to make sure role is in the allowed list
    if not roles.map{ |i| i.to_s }.include? current_user.role
      flash[:alert] = "Action available to " +
                      roles.to_sentence +
                      ' roles , but you are a ' +
                      current_user.role
                      "."
      redirect_to root_url
      return false
    end

    flash[:error] = "okaaayy..?"
    return true
  end
  
  def authorized_for?(user)
	user == current_user or current_user.role == :admin.to_s
  end
  
  def authenticate_and_authorize_user
    authenticate_user! or authorize([:user, :admin])
  end
end
