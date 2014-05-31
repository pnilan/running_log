class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			# sign in user and redirect to home page or desired protected page
			sign_in user
			redirect_back_or root_url
		else
			# Create an error message and render signin form
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy	
		sign_out
		redirect_to root_url
	end

end
