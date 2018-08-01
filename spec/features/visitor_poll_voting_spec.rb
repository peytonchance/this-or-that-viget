require 'rails_helper' 

RSpec.describe "Voting on a poll as a visitor", type: :feature, js:true do
  context "with an existing poll" do
    let!(:poll) {create(:poll, title: "Voting Poll", option_a: 'Choice 1', option_b: 'Choice 2')}

    before do
      visit root_path
    end

    it 'allows visitor to vote' do
      expect(page).to have_content '0 votes'

      option_a_element = find("#option-a-#{poll.id}")
      option_a_element.click

      sleep(inspection_time=0.5)

      expect(option_a_element).to have_content '100%'
      expect(page).to have_content '1 vote'
      expect(find("#option-b-#{poll.id}")).to have_content ''
    end

    it 'allows visitor to change the vote' do
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

    it 'allows visitor to retract the vote' do
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

    it 'shows interim vote results if visitor has already voted and reloads page' do
      expect(page).to have_content '0 votes'

      option_a_element = find("#option-a-#{poll.id}")
      option_a_element.click

      sleep(inspection_time=0.5)

      expect(option_a_element).to have_content '100%'
      expect(page).to have_content '1 vote'
      expect(find("#option-b-#{poll.id}")).to have_content ''

      page.evaluate_script 'window.location.reload()'

      expect(page).to have_content '1 vote'
      expect(option_a_element).to have_content '100%'
      expect(find("#option-b-#{poll.id}")).to have_content ''
    end

    context "with votes already on the poll" do
      before do
        create(:vote, poll: poll, option: 1)
        create(:vote, poll: poll, option: 1)
      end

      it 'allows visitor to vote' do
        visit root_path
        expect(page).to have_content '2 votes'
        option_a_element = find("#option-a-#{poll.id}")
        option_a_element.click

        sleep(inspection_time=0.5)

        expect(page).to have_content '3 votes'
        expect(option_a_element).to have_content '33%'
        expect(find("#option-b-#{poll.id}")).to have_content '67%'
      end
    end
  end
end