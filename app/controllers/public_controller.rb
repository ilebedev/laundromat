class PublicController < ApplicationController
  skip_before_filter :authenticate_user!

  def root
    if user_signed_in?
      redirect_to users_path
    end
  end
end
