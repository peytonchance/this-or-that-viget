require 'rails_helper'

RSpec.describe "Clicking Popular or Most Recent on Feed", type: :feature do
  context "with existing polls, votes, and users" do
    let!(:first_user) {create(:user)}
    let!(:second_user) {create(:user)}
    
    let!(:first_poll) {create(:poll, title: "First Poll")}
    let!(:second_poll) {create(:poll, title: "Second Poll")}
    
    before do
      create(:vote, poll: first_poll, user: first_user, option: 0)
      create(:vote, poll: first_poll, user: second_user, option: 0)
      visit root_path
    end
    
    it 'filters based on recency' do
      click_on 'Most Recent'
      expect(find('#article-poll-0')).to have_content 'Second Poll'
      expect(find('#article-poll-1')).to have_content 'First Poll'
    end
    
    it 'filters based on popularity' do
      click_on 'Popular'
      expect(find('#article-poll-0')).to have_content 'First Poll'
      expect(find('#article-poll-1')).to have_content 'Second Poll'
    end
  end
end