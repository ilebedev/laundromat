class PublicController < ApplicationController
  # NOTE: public action (root), no authorization
  before_filter :check_token

  def root
    if user_signed_in? and user_is_at_least_user?
      redirect_to media_path
    end
  end
  
  private
    def check_token
      if (params[:token] and Invite.exists?(token: params[:token]))
        session[:token] = params[:token]
      end
    end
end
