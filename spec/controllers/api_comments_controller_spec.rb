require "rails_helper"

RSpec.describe Api::CommentsController, type: :controller do
  let!(:token) {Rails.application.credentials.dig(:app_key)}
  context "with existing poll, user, and comments" do
    let!(:user) {create(:user)}
    let!(:poll) {create(:poll)}
    let!(:comment) {create(:comment, poll: poll, user: user)}

    describe "showing comments" do
      it 'responds with error without poll ID' do
        get :show, params: {
          token: token,
          poll_id: 0
        }
        
        expect(response.body).to eq({
          status: "error",
          message: "Invalid Poll ID"
        }.to_json)
        expect(response.status).to eq(401)
      end
      
      it 'shows the number of comments currently on poll' do
        get :show, params: {
          token: token,
          poll_id: poll.id,
          filter: "count"
        }
        
        expect(response.body).to eq({
          status: "success",
          comment: poll.comments.count
        }.to_json)
        expect(response.status).to eq(200)
      end
      
      it 'shows the comments currently on poll' do
        get :show, params: {
          token: token,
          poll_id: poll.id
        }
        
        expect(response.body).to eq({
          status: "success",
          comment: poll.comments
        }.to_json)
        expect(response.status).to eq(200)
      end
    end
    
    describe "creating a comment" do
      it 'responds with error without user ID' do
        post :create, params: {
          token: token,
          poll_id: poll.id,
          comment: {
            body: "API Comment"
          }
        }
        
        expect(response.body).to eq({
          status: "error",
          message: "Invalid User ID"
        }.to_json)
        expect(response.status).to eq(401)
      end
      
      it 'creates a comment on the poll' do
        post :create, params: {
          token: token,
          poll_id: poll.id,
          user_id: user.id,
          comment: {
            body: "API Comment"
          }
        }
        
        comment = poll.comments.last
        expect(response.body).to eq({
          status: "success",
          comment: comment
          }.to_json)
        expect(response.status).to eq(200)
      end
    end
  end
end
