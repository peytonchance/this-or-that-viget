require "rails_helper"

RSpec.describe Api::RegistrationsController, type: :controller do
  let!(:token) {Rails.application.credentials.dig(:app_key)}
  
  #One time test throughout all controller specs.
  context "with an invalid token" do
    it "does not let you create new user" do
      post :create, params: {
          token: 'invalidtoken',
          user: {
            username: 'apiuser',
            email: 'apiuser@example.com',
            password: 'password',
            password_confirmation: 'password'
            }
        }
      
      expect(response.body).to eq ({
        status: "error",
        message: "App Token is Invalid"
        }.to_json)
      expect(response.status).to eq(401)
    end
  end
  
  context "with a valid token" do
    it 'does not create a user with incorrect parameters' do
      post :create, params: {
          token: token,
          user: {
            username: 'apiuser',
            email: 'apiuser@example.com',
            password: 'password',
            password_confirmation: 'nonmatching'
          }
        }
      
      expect(response.body).to eq({
        "status": "error",
        "messsage": [
          "Password confirmation doesn't match Password"
          ]
        }.to_json)
    end
    
    it 'does create a user with correct parameters' do
      post :create, params: {
          token: token,
          user: {
            username: 'apiuser',
            email: 'apiuser@example.com',
            password: 'password',
            password_confirmation: 'password'
            }
        }
      
      user = User.first
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