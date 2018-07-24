class Api::ApiController < ApplicationController
  skip_forgery_protection
  
  before_action :verify_app_token
  
  def verify_app_token
    if params[:token] != Rails.application.credentials.dig(:app_key) 
      render json: {
        "status": "error",
        "message": "App Token is Invalid"
        }, status: :unauthorized
    end
  end
end