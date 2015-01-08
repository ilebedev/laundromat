class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Require authentication in all places except where explicitly omitted
  # to omit, add #skip_before_filter :authenticate_user!, :only => [:index]
  config.to_prepare do
    Devise::SessionsController.skip_before_filter :authenticate_user!
  end
  before_filter :authenticate_user!

  #TODO: do we need this?
  def new_session_path(scope)
    new_user_session_path
  end
end
