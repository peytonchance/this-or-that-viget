require "rails_helper"

RSpec.describe RegistrationController, type: :controller do 
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  it 'save cookies if user registers' do
    post :create, params: {
      user: attributes_for(:user)  
      }

    expect(response.cookies["user_id"]).to_not eq(nil)
  end
end

RSpec.describe SessionsController, type: :controller do
  context "with an existing user" do
    let!(:user) {create(:user)}
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    it 'save cookies if user registers' do
      post :create, params: {
        user: {
          email: user.email,
          password: user.password
          }
        }

      expect(response.cookies["user_id"]).to_not eq(nil)
    end
    
    it 'deletes cookie when user signs out' do
      post :create, params: {
        user: {
          email: user.email,
          password: user.password
          }
        }

      expect(response.cookies["user_id"]).to_not eq(nil)
      
      delete :destroy
      expect(response.cookies["user_id"]).to eq(nil)
    end
  end
end