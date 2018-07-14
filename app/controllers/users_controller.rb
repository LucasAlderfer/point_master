class UsersController < ApplicationController

  def index
    set_admin
    unless session[:current_user_id].nil?
      @user = User.find(session[:current_user_id])
    end
  end

  def show
    set_admin
    @user = User.find(params[:id])
  end

  def registration
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      flash[:error] = "All fields are required! No duplicate accounts allowed!"
      redirect_to users_registration_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
