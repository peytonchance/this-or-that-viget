require 'rails_helper' 

RSpec.describe "Resetting a password", type: :feature, js:true do

  context "with an existing user" do
    let!(:user) {create(:user)}

    before do
      login_as(user)
      visit root_path
      click_on user.username
      click_on 'reset password'
      fill_in 'Email', with: user.email
      click_on 'Send password reset instructions'
      #Wait for Devise to send mail. If there is another way to do this please let me know.
      sleep(inspection_time=0.5)
      visit(links_in_email(ActionMailer::Base.deliveries.first)[0].gsub("http://localhost:3000", ""))
    end

    it 'does not update non-matching passwords' do
      fill_in "New password", with: 'password'
      fill_in "Confirm new password", with: 'invalid'
      click_on 'Change my password'
      expect(page).to have_content "Password confirmation doesn't match Password"
    end
    
    it 'updates user password' do
      fill_in "New password", with: 'newpassword1'
      fill_in "Confirm new password", with: 'newpassword1'
      click_on 'Change my password'
      expect(page).to have_current_path root_path
      click_on user.username
      click_on 'log out'
      click_on 'Log in'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'newpassword1'
      click_button 'Log in'
    end
  end
end