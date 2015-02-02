class StreamsController < ApplicationController
  # Users can list and view; Admin can do everything else
  before_filter :authenticate_and_authorize_at_least_admin

  def index
    @media = Medium.all
    @orphans = Stream.orphans
    @new_medium = Medium.new
  end

  def edit
    @stream = Stream.find(params[:id])
  end

  def update
    @stream = Stream.find(params[:id])

    if @stream.update(stream_params)
      redirect_to streams_path
    else
      flash[:alert] << @stream.errors.full_messages.to_sentence

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
      params.require(:stream).permit(:description, :imdb_link, :date_produced)
    end
end
