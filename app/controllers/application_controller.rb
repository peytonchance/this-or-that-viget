class ApplicationController < ActionController::Base
  before_action :sign_user_in_from_cookie
  before_action :get_remote_ip
  rescue_from "ActiveRecord::RecordNotFound", with: :record_error
  
  def sign_user_in_from_cookie
    if cookies.signed[:user_id] && !user_signed_in?
      sign_in("user", User.find(cookies.signed[:user_id]))
    end
  end
  
  def record_error(exeception)
    redirect_to polls_path
  end
  
  def get_remote_ip
    @ip = request.remote_ip
  end
end
