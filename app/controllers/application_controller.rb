class ApplicationController < ActionController::Base
  rescue_from "ActiveRecord::RecordNotFound", with: :record_error
  
  def record_error(exeception)
    redirect_to polls_path
  end
end
