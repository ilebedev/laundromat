class StreamsController < ApplicationController
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
