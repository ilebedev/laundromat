class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Record time of last interaction with each user
  before_filter :update_last_seen

  # Initialize flash messages
  prepend_before_filter :initialize_flash

  def self.create_authorization_methods (role)
    class_eval %Q{
      helper_method :user_is_at_least_#{role}?
      def user_is_at_least_#{role}?
        user_role = User::ROLES.index(:#{role})
        current_role = User.roles.keys.index(current_user.role)
        current_role >= user_role
      end

      def authenticate_and_authorize_at_least_#{role}
        authorized_roles = User::ROLES.drop(User::ROLES.index(:#{role}))
        authenticate_user! and authorize(authorized_roles)
      end
    }
  end

  User::ROLES.each do |role|
    create_authorization_methods(role)
  end

  def authorized_for? (user)
    user == current_user or current_user.role == :admin.to_s
  end

  def authorize_for (user)
    unless authorized_for? user
      flash[:alert] << 'Action available to a specific other user' +
                       # (this leaks information) user.first_name +
                       ' or an Admin, but you are ' +
                       current_user.first_name +
                       ' the ' +
                       current_user.role +
                       '.'
      redirect_to root_url
      return false
    end
    return true
  end

  private
    def initialize_flash
      flash[:notice] ||= [];
      flash[:alert] ||= [];
    end

    def update_last_seen
      if current_user
        current_user.update(last_seen: DateTime.current())
      end
    end

    def become_user(user)
      sign_in_and_redirect user
      flash[:notice] << 'Became ' + user.first_name + ' the ' + user.role + '!'
    end

    def authorize(roles)
      # prerequisite: the user must be signed in
      # check to make sure role is in the allowed list
      if not roles.map{ |i| i.to_s }.include? current_user.role
        flash[:alert] << 'Action available to ' +
                         roles.to_sentence +
                         ' roles, but you are merely a ' +
                         current_user.role +
                         '.'
        redirect_to root_url
        return false
      end
      return true
    end

    def restrict_to_development
      head(:bad_request) unless Rails.env.development?
    end
end
