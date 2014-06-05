class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params) 
  	if @user.save
      sign_in @user
      flash[:success] = "Welcome to SecondWind!"
  		redirect_to root_url
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Changes saved."
      render 'edit'
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    if current_user.admin?
      flash[:success] = "User account deleted."
      redirect_to users_url
    else
      flash[:success] = "Account successfully deleted."
      redirect_to root_url
    end
  end

  private

  	def user_params
  		params.require(:user).permit(:username, :name, :location, :email, :password, :password_confirmation)
  	end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)      
    end
end
