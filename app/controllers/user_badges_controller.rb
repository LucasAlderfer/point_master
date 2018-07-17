class UserBadgesController < ApplicationController

  def create
    userbadge = UserBadge.new(badge_id:params[:user_badge][:badge_id], user_id:params[:user_id])
    user = User.find(params[:user_id])
    if userbadge.save
      flash[:notice] = "New Badge added for #{user.email}!"
      redirect_to admin_management_index_path
    else
      flash.now[:error] = "Badge Not Created!"
    end
  end

  def buy
    user = User.find(params[:user_id])
    badge = Badge.find(params[:badge_id])
    unless user.point_count >= badge.value
      flash[:notice] = "You do not have enough points to buy that badge!"
      redirect_to badge_store_path
    else
      user.user_badges.create(badge:badge)
      flash[:notice] = "#{badge.title} Badge Added!"
      redirect_to user_path(user)
    end
  end

  private

  def userbadge_params
    params.require(:user_badge).permit(:badge_id)
  end
end
