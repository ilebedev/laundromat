class UsersController < ApplicationController
  # NOTE: Guest can do anything (to self) except index, Admin can do everything
  before_filter :authenticate_and_authorize_at_least_admin, only: [:index]
  before_filter :authenticate_and_authorize_for_user, except: [:index]

  def authenticate_and_authorize_for_user
    @user = User.find params[:id]
    authenticate_and_authorize_at_least_guest and authorize_for @user
  end

  def index
    @users = User.all
  end

  def edit
    # @user is initialized by the before_filter
  end

  def show
    # @user is initialized by the before_filter
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :image, :email)
    end

    def admin_params
      params.require(:user).permit(:first_name, :image, :email, :role)
    end
end
