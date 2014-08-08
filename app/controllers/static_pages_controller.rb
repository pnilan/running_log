class StaticPagesController < ApplicationController

  def home
  	if !signed_in?
      render layout: "landing_page"
  	end
  end

  def contact
  end

  def about
  end
end
