class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		@activities = current_user.activities
  		@date = params[:month] ? Date.parse("01-#{params[:month]}") : Date.today
    else
      render layout: "landing_page"
  	end
  end

  def contact
  end

  def about
  end
end
