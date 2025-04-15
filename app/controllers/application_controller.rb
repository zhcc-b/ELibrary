class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user, :logged_in?, :admin?

  protected

  # 配置Devise允许的参数
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :role ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username, :role ])
  end

  private

  # use Devise's current_user method
  def current_user
    if respond_to?(:warden) && warden.user
      warden.user
    else
      @current_user ||= User.find(session[:user_id]) if session[:user_id]  # 回退到自定义会话
    end
  end

  def logged_in?
    !!current_user
  end

  def admin?
    current_user && current_user.role == "admin"
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
