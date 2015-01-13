class PublicController < ApplicationController
  skip_before_filter :authenticate_and_authorize_user, only: [:root]

  def root
    if user_signed_in?
      redirect_to streams_path
    end
  end
end
