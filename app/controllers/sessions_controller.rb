class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    @admin = Admin.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    elsif @admin && @admin.authenticate(params[:password])
      session[:admin] = true
      redirect_to admins_path
    else
      flash.now[:notice] = "Sorry that email and password combination is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:admin] = nil
    flash[:notice] = 'You have been logged out!'
    redirect_to users_path
  end

end
