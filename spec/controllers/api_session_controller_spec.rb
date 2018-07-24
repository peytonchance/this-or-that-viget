require "rails_helper"

RSpec.describe Api::SessionsController, type: :controller do
  let!(:token) {Rails.application.credentials.dig(:app_key)}

  context "with a user already created" do
    let!(:user) {create(:user)}

    it 'does not let you sign in with invalid email/password' do
      post :create, params: {
        token: token,
        user: {
          email: user.email,
          password: 'invalid'
          }
        }

      expect(response.body).to eq({
        "status": "error",
        "message": "Invalid email or password."
        }.to_json)

      post :create, params: {
        token: token,
        user: {
          email: 'fakeemail@123.com',
          password: user.password
          }
        }

      expect(response.body).to eq({
        "status": "error",
        "message": "Invalid email or password."
        }.to_json)
    end
    
    it 'does let you sign in with valid credentials' do
      post :create, params: {
        token: token,
        user: {
          email: user.email,
          password: user.password
          }
        }

      expect(response.body).to eq({
        "status": "success",
        "user": { 
          "id": user.id,
          "email": user.email,
          "username": user.username
          }
        }.to_json)

    end
  end
end