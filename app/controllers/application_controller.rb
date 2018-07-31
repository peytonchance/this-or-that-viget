class ApplicationController < ActionController::Base
  before_action :sign_user_in_from_cookie
  
  def sign_user_in_from_cookie
    if cookies.signed[:user_id] && !user_signed_in?
      sign_in("user", User.find(cookies.signed[:user_id]))
    end
  end
end
