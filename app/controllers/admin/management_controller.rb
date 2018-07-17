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

end
