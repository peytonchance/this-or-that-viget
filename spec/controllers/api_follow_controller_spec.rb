require "rails_helper"

RSpec.describe Api::FollowsController, type: :controller do
  let!(:token) {Rails.application.credentials.dig(:app_key)}

  context "with existing polls, users, and follows" do
    let!(:user) {create(:user)}
    let!(:poll) {create(:poll)}
    let!(:follow) {create(:follow, poll: poll, user: user)}

    it 'responds with error without valid poll ID' do
      get :show, params: {
        token: token,
        poll_id: 0,
        user_id: user.id
        }

      expect(response.body).to eq({
        status: "error",
        message: "Invalid Poll ID"
      }.to_json)
      expect(response.status).to eq(422)
    end

    it 'responds with error without valid user ID' do
      get :show, params: {
        token: token,
        poll_id: poll.id,
        user_id: 0
      }

      expect(response.body).to eq({
        status: "error",
        message: "Invalid User ID"
      }.to_json)
      expect(response.status).to eq(422)
    end

    describe "creating a follow" do
      it 'creates a new follow with valid params' do
        follow_user = create(:user)
        expect do
          post :create, params: {
            token:   token,
            poll_id: poll.id,
            user_id: follow_user.id
          }
        end.to change { poll.follows.count }.by(1)

        expect(response.body).to eq({
          status: "success",
          follow: true
        }.to_json)
        expect(response.status).to eq(200)
        expect(poll.follows.last.user).to eq(follow_user)
      end
    end

    describe "showing if user is following poll" do
      it 'shows true' do
        get :show, params: {
          token: token,
          poll_id: poll.id,
          user_id: user.id
        }

        expect(response.body).to eq({
          status: "success",
          follow: true
        }.to_json)
        expect(response.status).to eq(200)
      end
    end
    
    describe "unfollowing a poll" do
      it 'unfollows the poll and returns false' do
        expect do
          delete :destroy, params: {
            token: token,
            poll_id: poll.id,
            user_id: user.id
          }
        end.to change { poll.follows.count }.by(-1)

        expect(response.body).to eq({
          status: "success",
          follow: false
        }.to_json)
        expect(response.status).to eq(200)
      end
    end
  end
end