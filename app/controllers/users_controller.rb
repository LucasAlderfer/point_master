class UsersController < ApplicationController
  before_action :current_user

  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error] = "All fields are required! No duplicate accounts allowed!"
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
