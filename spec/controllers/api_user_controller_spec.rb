require "rails_helper"

RSpec.describe Api::UsersController, type: :controller do
  let!(:token) {Rails.application.credentials.dig(:app_key)}

  context "with a user already created" do
    let!(:user) {create(:user)}
    
    it 'returns invalid response with invalid user id' do
      get :show, params: {
        token: token,
        id: 0
      }
      
      expect(response.body).to eq({
        status: "error",
        message: "Invalid request"
      }.to_json)
      
      expect(response.status).to eq(400)
    end
    
    it 'returns user with valid id' do
      get :show, params: {
        token: token,
        id: user.id
      }
      
      expect(response.body).to eq({
        status: "success",
        user: user
      }.to_json)
      
      expect(response.status).to eq(200)
    end
  end
end