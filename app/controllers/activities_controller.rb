require 'chronic_duration'

class ActivitiesController < ApplicationController
before_action :signed_in_user, only: [:create, :destroy, :edit, :update, :index]
before_action :correct_user, only: [:destroy, :edit, :update]

  def index
    @activities = Activity.all
  end
  
  def new
    @activity = Activity.new
  end

  def create  	
  	@activity = current_user.activities.build(activity_params)
  	if @activity.save
  		flash[:success] = "New activity added!"
  	  redirect_to dashboard_home_path
    else
      render 'new'
    end
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
  	render 'edit'
  end

  def destroy
  	@activity.destroy
  	flash[:notice] = "Activity deleted."
  	redirect_to root_url  	
  end

  private

  	def activity_params
  		params.require(:activity).permit(:date, :distance, :duration, :pace, :content, :calories, :type_id)
  	end

  	# Before filters

  	def correct_user
  		@activity = current_user.activities.find_by(id: params[:id])
  		redirect_to dashboard_index_path if @activity.nil?
  	end
end
