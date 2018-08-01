require 'rails_helper' 

RSpec.describe "Voting on a poll", type: :feature, js:true do
  context "with an existing poll and user" do
    let!(:user) {create(:user)}
    let!(:poll) {create(:poll, title: "Voting Poll", option_a: 'Choice 1', option_b: 'Choice 2')}

    before do
      visit root_path
    end

    it 'does not allow you to vote without being signed in' do
      option_a_element = find("#option-a-#{poll.id}")
      option_a_element.click
      expect(option_a_element).to_not have_content '100%'
    end

    context "user being signed in" do
      it 'clicking on vote for first time reveals percentage' do
        login_as(user)
        visit root_path
        expect(page).to have_content '0 votes'

        option_a_element = find("#option-a-#{poll.id}")
        option_a_element.click

        sleep(inspection_time=0.5)

        expect(option_a_element).to have_content '100%'
        expect(page).to have_content '1 vote'
        expect(find("#option-b-#{poll.id}")).to have_content ''
      end

      it 'allows user to change the vote' do
        login_as(user)
        visit root_path
        expect(page).to have_content '0 votes'

        option_a_element = find("#option-a-#{poll.id}")
        option_b_element = find("#option-b-#{poll.id}")
        option_a_element.click

        sleep(inspection_time=0.5)
        expect(page).to have_content '1 vote'
        expect(option_a_element).to have_content '100%'
        expect(option_b_element).to have_content ''

        option_b_element.click
        sleep(inspection_time=0.5)
        expect(page).to have_content '1 vote'
        expect(option_a_element).to have_content ''
        expect(option_b_element).to have_content '100%'
      end

      it 'allows user to retract the vote' do
        login_as(user)
        visit root_path
        expect(page).to have_content '0 votes'

        option_a_element = find("#option-a-#{poll.id}")
        option_b_element = find("#option-b-#{poll.id}")
        option_a_element.click

        sleep(inspection_time=0.5)
        expect(page).to have_content '1 vote'
        expect(option_a_element).to have_content '100%'
        expect(option_b_element).to have_content ''

        option_a_element.click

        sleep(inspection_time=0.5)
        expect(page).to have_content '0 votes'
        expect(page).to_not have_content '%'
      end
    end

    context "with two users, one being signed in" do
      let!(:secondary) {create(:user)}
      before do
        create(:vote, poll: poll, user: user, option: 1)
        login_as(secondary)
        visit root_path
      end

      it 'displays 50/50 when clicking on the other option' do
        expect(page).to have_content '1 vote'
        option_a_element = find("#option-a-#{poll.id}")
        option_b_element = find("#option-b-#{poll.id}")
        option_a_element.click

        expect(page).to have_content '2 votes'
        expect(option_a_element).to have_content '50%'
        expect(option_b_element).to have_content '50%'
      end
    end
    
    context "expired poll with multiple votes" do
      before do
        poll.update_attributes(expired: true)
        create(:vote, poll: poll, option: 0)
        create(:vote, poll: poll, option: 0)
        create(:vote, poll: poll, option: 1)
      end
      
      it 'automatically shows poll results if poll is expired' do
        visit root_path
        expect(find("#option-a-#{poll.id}")).to have_content '67%'
        expect(find("#option-b-#{poll.id}")).to have_content '33%'
      end
    end
    
    context "user owns the poll" do
      before do
        create(:vote, poll: poll, option: 0)
        create(:vote, poll: poll, option: 0)
        create(:vote, poll: poll, option: 1)
        login_as(user)
      end
      
      it 'autoamtically shows interim poll results if user owns poll' do
        poll.update_attributes(user: user)
        visit root_path
        expect(find("#option-a-#{poll.id}")).to have_content '67%'
        expect(find("#option-b-#{poll.id}")).to have_content '33%'
      end
      
      it 'does not show interim poll results if user does not own poll' do
        visit root_path
        expect(page).to_not have_content '%'
      end
    end
  end
end