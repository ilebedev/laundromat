class PublicController < ApplicationController
  # NOTE: public action (root), no authorization

  def root
    if user_signed_in? and user_is_at_least_user?
      redirect_to media_path
    end
  end
end
