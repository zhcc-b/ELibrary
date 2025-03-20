class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :admin?

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def admin?
    current_user && current_user.role == "admin"
    # logged_in?
  end

  def require_user
    unless logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

  def require_admin
    unless admin?
      flash[:alert] = "You must be an admin to perform that action"
      redirect_to root_path
    end
  end
end
