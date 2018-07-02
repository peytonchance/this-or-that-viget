require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "with an Article already created" do
    let!(:poll) {create(:poll)}
    let!(:comment_user) {create(:user, username: 'commenter', email: 'commenter@viget.com')}
    
    
    it "currently has no comments on the article" do
      expect(poll.comments.count).to eq(0)
    end
    
    
    let(:comment) {create(:comment, user: comment_user, poll: poll)}
    
    it "creates a comment" do
      expect(comment.poll).to eq(poll)
      expect(poll.comments.first).to eq(comment)
    end
  end
end
