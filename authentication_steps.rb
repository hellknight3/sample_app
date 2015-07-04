require 'factories'
Given /^a user visits the signin page$/ do
  visit signin_path
end
When /^they submit invalid signin information$/ do
  click_button "Sign in"
end
Then /^they should see an error message$/ do
  expect(page).to have_selector('div.alert.aler-error')
end
Given(/^a doctor is logged in$/) do
  @user = FactoryGirl.create(:userDoctor)
end
Given (/^a admin is logged in$/) do
  @user = FactoryGirl.create(:userAdmin)
end
Given (/^a patient is logged in$/) do
  @user = FactoryGirl.create(:userPatient)
end
