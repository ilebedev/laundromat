class RequestsController < ApplicationController
  # Users can list and view; Admin can do everything else
  before_filter :authenticate_and_authorize_at_least_user, only: [:index, :new]
  before_filter :authenticate_and_authorize_at_least_admin, except: [:index, :new]

  def index
    @requests = Request.all
  end

  def new
    @request = Request.new  
  end

  def edit
    if user_is_at_least_admin?
      @request = Request.find(params[:id])
    else
      redirect_to requests_path
    end
  end

  def create
    @request = Request.new(request_params)

    if @request.save
      redirect_to requests_path
    else
      render 'new'
    end
  end

  def update
    @request = Request.find(params[:id])

    if @request.update(request_params)
      redirect_to requests_path
    else
      render 'edit'
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    redirect_to requests_path
  end

  private
    def request_params
      params.require(:request).permit(:title, :category, :description, :link)
    end
end
