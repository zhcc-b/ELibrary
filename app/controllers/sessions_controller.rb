class SessionsController < ApplicationController
  def new
    # 如果用户已经通过 Devise 登录，重定向到首页
    if user_signed_in?
      flash[:notice] = "You are already logged in."
      redirect_to root_path
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.valid_password?(params[:session][:password])
      # 同时设置 Devise 会话和自定义会话
      sign_in(user) if !user_signed_in?
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully!"
      redirect_to user
    else
      flash.now[:alert] = "There was something wrong with your login details."
      render :new
    end
  end

  def destroy
    # 同时清除 Devise 会话和自定义会话
    sign_out(current_user) if user_signed_in?
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_path
  end
end
