require 'rails_helper' 

RSpec.describe "Requesting to reset password", type: :feature, js:true do

  context "with an existing user" do
    let!(:user) {create(:user)}

    before do
      login_as(user)
      visit root_path
    end

    it 'does not send email to incorrect email' do
      click_on user.username
      click_on 'reset password'
      fill_in 'Email', with: "fakeemail@invalid.com"
      click_on 'Send password reset instructions'
      expect(page).to have_content "Incorrect Email."

      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end

    it 'sends email confirmation' do
      click_on user.username
      click_on 'reset password'
      fill_in 'Email', with: user.email
      click_on 'Send password reset instructions'
      expect(page).to have_content 'Reset Password Link Sent to Email'

      expect(ActionMailer::Base.deliveries.count).to eq(1)
      mail = ActionMailer::Base.deliveries.first
      expect(mail).to deliver_to user.email
    end
  end
end