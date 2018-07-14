class SessionsController < ApplicationController

  def login
  end

  def authenticate
    user = User.authenticate(params[:email], params[:password])
    admin = Admin.authenticate(params[:email], params[:password])
    if user.nil? && admin.nil?
      flash.now[:notice] = "Sorry that email and password combination is invalid"
      render :login
    elsif admin.nil?
      session[:current_user_id] = user.id
      redirect_to user_path(user)
    elsif !admin.nil?
      session[:admin] = true
      redirect_to admins_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    flash[:notice] = 'You have been logged out!'
    redirect_to users_path
  end

  private

  # def login_params
  #   params.require(:email).require(:password).permit(:email, :password)
  # end

end
