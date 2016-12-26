require 'spec_helper'

feature 'Inviting users' do
  let!(:admin) { create(:user, :admin) }

  scenario 'inviting a new user,
            viewing the invitation status,
            editing the email, logging in and setting password' do

    visit root_path
    fill_in 'user[email]' , with: admin.email
    fill_in 'user[password]', with: 'password123'

    click_button "Log in"
    click_link "Users"
    click_link "Invite user"

    fill_in 'user[email]', with: 'new-user@example.com'
    click_button "Invite user"

    expect(User.count).to eq 2
  end
end