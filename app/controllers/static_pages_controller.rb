class StaticPagesController < ApplicationController
layout "landing_page"

  def home
  	if signed_in?
  		redirect_to controller: "dashboard", action: "index"
  	end
  end

  def contact
  end

  def about
  end
end
