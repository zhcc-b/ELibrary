class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update ]
  before_action :require_same_user, only: [ :edit, :update ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = "user" # "admin"  Default role is user

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to ELibrary, #{@user.username}! You have successfully signed up."
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    # @user is set by before_action
    @bookmarks = @user.bookmarks.includes(:book)
  end

  def edit
    # @user is set by before_action
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated."
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !admin?
      flash[:alert] = "You can only edit your own account."
      redirect_to @user
    end
  end
end
