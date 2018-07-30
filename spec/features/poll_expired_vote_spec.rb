require 'rails_helper' 

RSpec.describe "Expired polls show results", type: :feature, js:true do
  context "with an existing poll, user, and votes" do
    let!(:user) {create(:user)}
    let!(:poll) {create(:poll, title: "Voting Poll", option_a: 'Choice 1', option_b: 'Choice 2')}

    it 'does not show current vote results' do
      visit root_path

      expect(page).to have_content 'Choice 1'
      expect(page).to have_content 'Choice 2'
      expect(page).to_not have_content '%'
    end

    it 'shows no percentage if poll is expired with no votes' do
      poll.expired = true
      poll.save
      visit root_path
      expect(page).to have_content '0 votes'
      expect(page).to have_content 'Choice 1'
      expect(page).to have_content 'Choice 2'
      expect(page).to_not have_content '%'
    end

    it 'shows percentage if poll is expired with votes' do
      create(:vote, poll: poll, user: user, option: 0)
      poll.expired = true
      poll.save
      visit root_path
      binding.pry
      expect(page).to have_content '1 vote'
      expect(find("#option-a-#{poll.id}")).to have_content '100%'
      expect(find("#option-b-#{poll.id}")).to have_content ''
    end
  end
end