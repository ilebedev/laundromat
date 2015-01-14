class UsersController < ApplicationController
  # NOTE: Guest can do anything (to self) except index, Admin can do everything
  before_filter :authenticate_and_authorize_at_least_admin, only: [:index]
  before_filter :authenticate_and_authorize_for_user, except: [:index]

  def authenticate_and_authorize_for_user
    @user = User.find params[:id]
    unless authenticate_and_authorize_at_least_guest
      return false
    end
    authorized_for? @user
  end

  def index
    unless user_is_at_least_admin?
      redirect_to root_path
    end

    @users = User.all
  end

  def edit
    unless authorized_for? @user
      redirect_to root_path
    end
  end

  def show
    unless authorized_for? @user
      redirect_to root_path
    end
  end

  def update
    if (user_is_at_least_admin? or authorized_for? @user) and @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if authorized_for? @user
      @user.destroy
    end

    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :image, :email)
    end

    def admin_params
      params.require(:user).permit(:first_name, :image, :email, :role)
    end
end
