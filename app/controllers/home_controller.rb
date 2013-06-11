class HomeController < ApplicationController
  
  def index
  	if current_user
  		redirect_to user_url(current_user)
  	end
  end

end
