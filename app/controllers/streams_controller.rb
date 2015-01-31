class StreamsController < ApplicationController
  # Users can list and view; Admin can do everything else
  before_filter :authenticate_and_authorize_at_least_user, only: [:show]
  before_filter :authenticate_and_authorize_at_least_admin, except: [:show]

  def index
    @streams = Stream.all
    @media = Medium.all
    @orphans = Stream.orphans
  end

  def show
    @stream = Stream.find(params[:id])
  end

  # def new does not exist

  def edit
    @stream = Stream.find(params[:id])
  end

  # def create does not exist

  def update
    @stream = Stream.find(params[:id])

    if @stream.update(stream_params)
      redirect_to @stream
    else
      render 'edit'
    end
  end

  def destroy
    @stream = Stream.find(params[:id])
    @stream.destroy

    redirect_to streams_path
  end

  private
    def stream_params
      params.require(:stream).permit(:title, :category, :description)
    end
end
