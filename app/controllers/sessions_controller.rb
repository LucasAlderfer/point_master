class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password]) && @user.admin?
      session[:user_id] = @user.id
      redirect_to admin_management_index_path
    elsif @user && @user.authenticate(params[:password]) && @user.default?
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash.now[:notice] = "Sorry that email and password combination is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have been logged out!'
    redirect_to users_path
  end

end
