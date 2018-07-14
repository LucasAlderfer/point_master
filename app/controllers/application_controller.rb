class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # helper_method :set_admin

  def set_admin
    @admin = true if session[:admin] == true
  end
end
