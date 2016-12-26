Given /^I am logged in as a user$/ do
  User.destroy_all
  user = User.create(:email => "jack@johnson.com",
                     :first_name => "Jack",
                     :last_name => "Johnson",
                     :roles_mask => 7,
                     :password => "12345678",
                     :password_confirmation => "12345678")

  visit new_user_session_path
  fill_in "user_email", :with => user.email
  fill_in "user_password", :with => "12345678"
  click_on "Log in"
end

Given(/^registrations are "([^"]*)"$/) do |state|
  value = (state == "enabled") ? "1" : "0"
  setting = Setting.find_or_initialize_by(:key => "allow_registrations")
  setting.update_attributes(:value => value)
end

When(/^I am on the sign up page$/) do
  visit "/users/sign_up"
end

When(/^I submit a new signup$/) do
  page.driver.post("/users", { :params => { :user_email => "test@example.com" } })
  expect(page.driver.status_code).to eq(302)
  visit page.driver.response.location
end

When(/^I register as "([^"]*)"$/) do |email|
  fill_in "user_email", :with => email
  fill_in "user_password", :with => "12345678"
  fill_in "user_password_confirmation", :with => "12345678"
  click_on "Sign up"
end

Then(/^I should delete user "([^"]*)"$/) do |email|
  user = User.find_by(:email => email)
  user.destroy!
end
