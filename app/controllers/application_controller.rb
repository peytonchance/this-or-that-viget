class ApplicationController < ActionController::Base
  def after_sign_in_path_for(user)
    polls_path
  end
  
  def after_sign_up_path_for(user)
    polls_path
  end
  
  def after_inactive_sign_up_path_for(user)
    polls_path
  end
end
