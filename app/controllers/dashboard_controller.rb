class DashboardController < ApplicationController

  def index
  	@user = current_user
  	@distance_today = Activity.distance_today(@user)
  	@distance_this_week = Activity.distance_this_week(@user)
  	@distance_this_month = Activity.distance_this_month(@user)
  end

end
