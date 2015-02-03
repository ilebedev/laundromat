class MediaController < ApplicationController
  # Users can list and view; Admin can do everything else
  before_filter :authenticate_and_authorize_at_least_user, only: [:index, :show]
  before_filter :authenticate_and_authorize_at_least_admin, except: [:index, :show]

  def index
    @media = Medium.all
    @request = Request.new
  end

  def show
    @medium = Medium.find(params[:id])
  end

  def create
    @medium = Medium.new(medium_params)

    if @medium.save
      redirect_to @medium
    else
      flash[:alert] = @medium.errors.full_messages.to_sentence
      redirect_to media_path
    end
  end

  def destroy
    @medium = Medium.find(params[:id])
    @medium.destroy

    redirect_to media_path
  end

  private
    def medium_params
      params.require(:medium).permit(:title, :category)
    end
end
