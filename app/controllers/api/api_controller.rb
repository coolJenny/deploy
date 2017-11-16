class Api::ApiController < ApplicationController
  # protect_from_forgery
  # skip_before_action :verify_authenticity_token

  # before_filter :user_authenticated?

  respond_to :json

  def current_user
    User.find_by(token: request.headers['Authentication'])
  end
  
  def user_authenticated?
    unless current_user
      render json: 'Unauthorized', status: :unauthorized and return
    end
  end
end