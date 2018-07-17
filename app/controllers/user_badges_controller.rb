class UserBadgesController < ApplicationController

  def create
    userbadge = UserBadge.new(badge_id:params[:user_badge][:badge_id], user_id:params[:user_id])
    user = User.find(params[:user_id])
    if userbadge.save
      flash[:notice] = "New Badge added for #{user}!"
      redirect_to admins_path
    else
      flash.now[:error] = "Badge Not Created!"
    end
  end

  private

  def userbadge_params
    params.require(:user_badge).permit(:badge_id)
  end
end
