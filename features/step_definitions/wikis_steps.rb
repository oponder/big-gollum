When /^I create a wiki called "([^"]*)"$/ do |wiki_name|
  visit root_path
  click_on "New wiki"
  fill_in "wiki_name", :with => wiki_name
  click_on "Create Wiki"
  @wiki_name = wiki_name
end

Then /^I should see "([^"]*)" in the list of wikis$/ do |wiki_name|
  visit root_path
  expect(page).to have_content(wiki_name)
end

Then /^I should not see "([^"]*)" in the list of wikis$/ do |wiki_name|
  visit root_path
  expect(page).to_not have_content(wiki_name)
end

Then /^I should be a member of the "([^"]*)" wiki$/ do |wiki_name|
  wiki = Wiki.find_by_name(wiki_name)
  expect(wiki.users.include?(User.first)).to eq(true)
end

Then /^the "([^"]*)" wiki should have a folder$/ do |wiki_name|
  expect(File.exists?(Rails.root.to_s + '/wikis/' + wiki_name)).to eq(true)
  expect(File.exists?(Rails.root.to_s + '/wikis/' + wiki_name + '/.git/')).to eq(true)
  expect(File.exists?(Rails.root.to_s + '/wikis/' + wiki_name + '/Home.md')).to eq(true)
end

When /^I go to the "([^"]*)" wiki$/ do |wiki_name|
  visit root_path
  click_on wiki_name
end

Then /^I should see "([^"]*)"$/ do |text|
  expect(page).to have_content text
end

When /^I go to the list of wikis$/ do
  visit root_path
end

When /^I edit a wiki called "([^"]*)" and name it "([^"]*)"$/ do |wiki_name,new_name|
  visit root_path
  click_on "edit_wiki-#{wiki_name}"
  fill_in "wiki_name", :with => new_name
  click_on "Update Wiki"
end

When /^I visit the "([^"]*)" wiki$/ do |wiki_name|
  visit "/wiki/" + wiki_name
end

When(/^I edit the wiki page$/) do
  click_on "Edit"
  fill_in "gollum-editor-body", :with => "this is a test"
  click_on "Save"
end

Then(/^the last edited info should be "([^"]*)"$/) do |name|
  expect(page).to have_content "Last edited by " + name
end

When(/^I click on the back to all wiki's button$/) do
  click_on "Back to all wikis"
end

When /^I delete the "([^"]*)" wiki$/ do |wiki_name|
  visit root_path
  click_on "delete_wiki-#{wiki_name}"
end

Then /^I should not see "([^"]*)"$/ do |text|
  expect(page).to_not have_content text
end

Then /^the "([^"]*)" wiki should not have a folder anymore$/ do |wiki_name|
  expect(File.exists?(Rails.root.to_s + '/wikis/' + wiki_name)).to_not eq(true)
end
