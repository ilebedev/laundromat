class InvitesController < ApplicationController
  # NOTE: only Admin can do these
  before_filter :authenticate_and_authorize_at_least_admin

  def index
    @invites = Invite.all
  end
  
  def new
	@invite = Invite.new
  end
  
  def create
    Invite.new(user: current_user).save
    redirect_to invites_path
  end

  def destroy
	@invite = Invite.find(params[:id])
    @invite.destroy
    redirect_to invites_path
  end

  private
    def invite_params
      params.require(:invite).permit(:expiration_date)
    end
end
