require 'chronic_duration'

class ActivitiesController < ApplicationController
before_action :signed_in_user, only: [:new, :create, :destroy, :edit, :update, :index]
before_action :correct_user, only: [:destroy, :edit, :update, :update]

  def index
    @activities = Activity.all
  end

  def show
    @activity = Activity.find(params[:id])
  end
  
  def new
    @activity = Activity.new
  end

  def create  	
  	@activity = current_user.activities.build(activity_params)
    @activity.user_id = current_user.id
  	if @activity.save
      flash[:success] = "New activity added!"
    else
      redirect_to new_activity_path
    end
    redirect_to dashboard_home_path
  end

  def edit
  	@activity = current_user.activities.find_by(id: params[:id])
  end

  def update
  	@activity = current_user.activities.find_by(id: params[:id])
  	if @activity.update_attributes(activity_params)
  		# Handle a successful update
  		flash[:notice] = "Activity updated."
  	end
  	render dashboard_calendar_path
  end

  def destroy
  	@activity.destroy
    redirect_to dashboard_calendar_path
  end

  private

  	def activity_params
  		params.require(:activity).permit(:date, :distance, :duration, :pace, :content, :run_type)
  	end

  	# Before filters

  	def correct_user
  		@activity = current_user.activities.find_by(id: params[:id])
  		redirect_to dashboard_home_path if @activity.nil?
  	end
end
