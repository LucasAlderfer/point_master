class BadgesController < ApplicationController

  def new
    require_admin
    @badge = Badge.new()
  end

  def create
    require_admin
    badge = Badge.create(badge_params)
    if badge.save
      flash[:notice] = "New Badge Added!"
      redirect_to admin_management_index_path
    else
      flash.now[:error] = "Badge Not Created!"
      render :new
    end
  end

  def index
    @badges = Badge.all
  end

  private

  def badge_params
    params.require(:badge).permit(:title, :value)
  end

end
