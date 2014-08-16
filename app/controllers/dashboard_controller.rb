class DashboardController < ApplicationController

  def index
  	@user = current_user
  	@distance_today = Activity.distance_today(@user)
  	@distance_this_week = Activity.distance_this_week(@user)
  	@distance_this_month = Activity.distance_this_month(@user)
  end

  def calendar
    @user = current_user
    # @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @activities = Activity.all
  end

  def analysis

  end

end
