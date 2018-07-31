require 'rails_helper'

RSpec.describe "Creating a poll", type: :feature, js:true do
  let!(:user) {create(:user)}
  
  before do
    login_as(user)
    visit root_path
  end

  describe "entering form information" do 
    it "properly creates a form" do
      #inputting form fields
      click_on "Create a Poll"
      fill_in 'poll-title', with: 'Demo Poll with Options'
      fill_in 'poll_option_a_url', with: 'https://www.gstatic.com/webp/gallery3/1.sm.png'
      fill_in 'poll_option_b_url', with: 'https://www.gstatic.com/webp/gallery3/1.sm.png'
      fill_in 'poll-option-a', with: 'Pizza'
      fill_in 'poll-option-b', with: 'Taco'
      fill_in 'poll_expire_days', with: '1'
      fill_in 'poll_expire_hours', with: '0'
      fill_in 'poll_expire_mins', with: '0'
      click_on 'Submit poll'

      poll = find('article.poll')
      expect(poll).to have_content user.username
      expect(poll).to have_content "1 day left"
      expect(poll).to have_content "Demo Poll with Options"
       
      #Can't test because of CSS styling 
      #expect(poll).to have_content "Pizza"
    end
    
    it 'error shows when expire time is set to now' do
      click_on "Create a Poll"
      fill_in 'poll-title', with: 'Demo Poll with Options'
      fill_in 'poll-option-a', with: 'Pizza'
      fill_in 'poll-option-b', with: 'Taco'
      fill_in 'poll_expire_days', with: '0'
      fill_in 'poll_expire_hours', with: '0'
      fill_in 'poll_expire_mins', with: '0'
      click_on 'Submit poll'
      
      expect(Poll.count).to eq(0)
      expect(page).to have_content 'Cannot set expiry time to now'

    end
    
    it "error shows when two images given for one option" do
      path = "#{Rails.root}/spec/fixtures/rspec_test_image.png"
      click_on "Create a Poll"
      fill_in 'poll-title', with: 'Demo Poll with Options'
      fill_in 'poll_option_a_url', with: 'https://www.gstatic.com/webp/gallery3/1.sm.png'
      find('#poll_option_a_img', visible: false).set(path)
      click_on 'Submit poll'
            
      expect(Poll.count).to eq(0)
      expect(page).to have_content 'Cannot have both a file attached and an image link. Please choose one option'
    end
  end
end