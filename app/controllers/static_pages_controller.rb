class StaticPagesController < ApplicationController
layout "landing_page"

  def home
  	if signed_in?
  		# redirect_to controller: "dashboard", action: "index"
  		redirect_to dashboard_index_path
  	end
  end

  def contact
  end

  def about
  end
end
