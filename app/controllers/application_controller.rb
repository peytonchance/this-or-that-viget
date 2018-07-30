class ApplicationController < ActionController::Base
  before_action :verify_cookies
  
  def verify_cookies
    if cookies.signed[:user_id] && !user_signed_in?
      sign_in("user", User.find(cookies.signed[:user_id]))
    end
  end
end
