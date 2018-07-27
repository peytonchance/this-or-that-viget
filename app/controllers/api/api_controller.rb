class Api::ApiController < ApplicationController
  skip_forgery_protection
  rescue_from "ActiveRecord::RecordNotFound", with: :render_error
  
  before_action :verify_app_token
  
  def verify_app_token
    if params[:token] != Rails.application.credentials.dig(:app_key) 
      render json: {
        "status": "error",
        "message": "App Token is Invalid"
        }, status: :unauthorized
    end
  end
  
  def render_error(exception)
    render({
      json:   {status: "error", message: "Invalid request"}, 
      status: :bad_request
    })
  end
end