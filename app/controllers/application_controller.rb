class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :set_admin, :current_user

  def current_user
    unless session[:user_id].nil?
      @current_user ||= User.find(session[:user_id])
    end
  end

  def set_admin
    @admin = true if session[:admin] == true
  end
end
