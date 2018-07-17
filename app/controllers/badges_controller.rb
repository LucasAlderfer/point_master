class BadgesController < ApplicationController

  def new
    @badge = Badge.new()
  end

  def create
    badge = Badge.create(badge_params)
    if badge.save
      flash[:notice] = "New Badge Added!"
      redirect_to admins_path
    else
      flash.now[:error] = "Badge Not Created!"
      render :new
    end
  end

  private

  def badge_params
    params.require(:badge).permit(:title, :value)
  end

end
