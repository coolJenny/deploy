class DashboardController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!


  def dashboard_buyer
  end
  def dashboard_manager
  end
  def dashboard_admin
  end
  # set another layout for a specific action
  def dashboard_h
    render :layout => 'application-h'
  end
end
