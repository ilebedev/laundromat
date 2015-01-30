class UsersController < ApplicationController
  # NOTE: Guest can do anything (to self) except index, Admin can do everything
  before_filter :authenticate_and_authorize_at_least_admin, only: [:index, :become]
  before_filter :authenticate_and_authorize_for_user, except: [:index, :become]

  def authenticate_and_authorize_for_user
    @user = User.find params[:id]
    authenticate_and_authorize_at_least_guest and authorize_for @user
  end

  def index
    @users = User.all
  end

  def become
    user = User.find params[:user_id]
    become_user(user)
  end

  def edit
    # @user is initialized by the before_filter
  end

  def show
    # @user is initialized by the before_filter
  end

  def update
    if user_is_at_least_admin? and @user.update(admin_params)
      redirect_to @user
    elsif user_is_at_least_user? and @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :image, :email)
    end

    def admin_params
      params.require(:user).permit(:first_name, :image, :email, :role)
    end
end
