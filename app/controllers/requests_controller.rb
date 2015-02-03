class RequestsController < ApplicationController
  # Users can list and view; Admin can do everything else
  before_filter :authenticate_and_authorize_at_least_user, only: [ :create ]
  before_filter :authenticate_and_authorize_at_least_admin, except: [ :create ]

  def index
    @requests = Request.all
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      flash[:notice] = "Cool, thanks for placing a request. We'll get right on it"
    else
      flash[:alert] = "Oh no! " + @request.errors.full_messages.to_sentence
    end
    redirect_to media_path
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    redirect_to requests_path
  end

  private
    def request_params
      params.require(:request).permit(:request)
    end
end
