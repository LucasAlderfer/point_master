class Admin::ManagementController < Admin::BaseController

  def index
    @users = User.all
    @user_badge = UserBadge.new
  end

  def add_point
    adding_user = User.find(params[:id])
    adding_user.points.create
    redirect_to admin_management_index_path
  end

  def remove_points
    removing_user = User.find(params[:edit_user_id])
    removing_user.delete_points(params[:remove_points].to_i)
    redirect_to admin_management_index_path
  end

  def enable_badge
    badge = Badge.find(params[:id])
    badge.enable_badge
    redirect_to badges_path
  end
end
