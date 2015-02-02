class InvitesController < ApplicationController
  # NOTE: only Admin can do these
  before_filter :authenticate_and_authorize_at_least_admin

  def index
    @new_invite = Invite.new
    @invites = Invite.all
  end

  # def new

  def create
    @invite = Invite.new( invite_params.merge({user: current_user}) )
    if not @invite.save
      flash[:alert] << @medium.errors.full_messages.to_sentence
    end
    redirect_to invites_path
  end

  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy
    redirect_to invites_path
  end

  private
    def invite_params
      params.require(:invite).permit(:memo)
    end
end
