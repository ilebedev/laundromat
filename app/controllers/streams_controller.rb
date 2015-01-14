class StreamsController < ApplicationController
  # Users can list and view; Admin can do everything else
  before_filter :authenticate_and_authorize_at_least_user, only: [:index, :show]
  before_filter :authenticate_and_authorize_at_least_admin, except: [:index, :show]

  def index
    @streams = Stream.all
  end

  def show
    @stream = Stream.find(params[:id])
  end

  def new
    @stream = Stream.new
  end

  def edit
    @stream = Stream.find(params[:id])
  end

  def create
    @stream = Stream.new(stream_params)

    if @stream.save
      redirect_to streams_path
    else
      render 'new'
    end
  end

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
