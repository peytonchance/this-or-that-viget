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
  
  def verify_user_id
    @user = User.find_by(id: params[:user_id]) if params[:user_id].present?
    if @user.nil?
      respond_with_error("Invalid User ID")
    end
  end

  def verify_poll_id
    @poll = Poll.find_by(id: params[:poll_id]) if params[:poll_id].present?
    if @poll.nil?
      respond_with_error("Invalid Poll ID")
    end
  end
  
  def respond_with_error(message, status: :unprocessable_entity)
    render(json: {status: "error", message: message}, status: status)
  end
end