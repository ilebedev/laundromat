class MediaController < ApplicationController
  # Users can list and view; Admin can do everything else
  before_filter :authenticate_and_authorize_at_least_user, only: [:index, :show]
  before_filter :authenticate_and_authorize_at_least_admin, except: [:index, :show]

  def index
    @media = Medium.all
  end

  def show
    @medium = Medium.find(params[:id])
  end

  def new
    @medium = Medium.new
  end

  def edit
    @medium = Medium.find(params[:id])
  end

  def create
    @medium = Medium.new(medium_params)

    if @medium.save
      redirect_to @medium
    else
      render 'new'
    end
  end

  def update
    @medium = Medium.find(params[:id])

    if @medium.update(medium_params)
      redirect_to @medium
    else
      render 'edit'
    end
  end

  def destroy
    @medium = Medium.find(params[:id])
    @medium.destroy

    redirect_to media_path
  end

  private
    def medium_params
      params.require(:medium).permit(:image_url, :title, :type)
    end

end
