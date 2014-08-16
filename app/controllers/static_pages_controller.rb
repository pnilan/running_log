class StaticPagesController < ApplicationController
layout "landing_page"

  def home
  	if signed_in?
  		redirect_to dashboard_home_path
  	end
  end

  def contact
  end

  def about
  end
end
