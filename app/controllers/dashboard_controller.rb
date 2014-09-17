class DashboardController < ApplicationController
  before_action :signed_in_user

  def index
  	@user = current_user
    @distance_today = Activity.distance_today(@user)
    @distance_this_week = Activity.distance_this_week(@user)
    @distance_this_month = Activity.distance_this_month(@user)
    @weekly_distances = @user.activities.this_week
    # @types = Type.all
  end

  def calendar
    @user = current_user
    @activities = @user.activities
    @types = Type.all
  end

  def analysis

  end

end
