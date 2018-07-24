class Api::RegistrationsController < Api::ApiController
  def create
    render json: {
      "status": "success",
      "user": "blah"
      }, status: :accepted
  end

  def show
    render json: {
      "status": "success"
      }, status: :accepted
  end
end