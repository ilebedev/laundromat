class UsersController < ApplicationController
  # Non-devise methods.
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
	unless authorized_for? @user
		flash[:alert] = "no peeking!"
	    redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
 
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
 
    redirect_to users_path
  end

  private
    def user_params
	  params.require(:user).permit(:first_name, :image, :email) 
	end
end
