class HomeController < ApplicationController
  layout "home"
  def index
  	if current_user && current_user.subscription_id != nil && current_user.subscription_id != ""
  		redirect_to '/skynets/new'
  	end
  end
  
  def userlist
   	@users = User.all
  end
end
