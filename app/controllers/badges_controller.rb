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

  def edit
    require_admin
    @badge = Badge.find(params[:id])
  end

  def update
    require_admin
    @badge = Badge.find(params[:id])
    @badge.update(badge_params)
    if @badge.save
      flash[:success] = "You updated #{@badge.title}"
      redirect_to badges_path
    else
      flash[:notice] = "Badge Update Could Not be Saved!"
      render :edit
    end
  end

  def index
    @badges = Badge.all
  end

  def destroy
    badge = Badge.find(params[:id])
    title = badge.title
    Badge.find(params[:id]).destroy
    flash[:success] = "You deleted #{title} badge!"
    redirect_to badges_path
  end

  private

  def badge_params
    params.require(:badge).permit(:title, :value)
  end

end
