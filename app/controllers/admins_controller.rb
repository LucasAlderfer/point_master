class AdminsController < ApplicationController

  def index
    set_admin
    unless @admin
      redirect_to users_path
    end
    @users = User.all
  end

  def add_point
    set_admin
    unless @admin
      redirect_to users_path
    end
    user = User.find(params[:id])
    user.points.create
    redirect_to admins_path
  end

end
