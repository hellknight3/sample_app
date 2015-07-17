When(/^they try to create a institution$/) do
  visit new_institution_path
end
Given(/^they visit the new institution path$/) do
  visit new_institution_path
end

When(/^they submit valid institution information$/) do
  @tempInstitution = FactoryGirl.build(:institution)
  fill_in "Name", :with =>  @tempInstitution.name
  fill_in "Description", :with => @tempInstitution.description
  click_button "Create Institution"
end

Then(/^a institution should be created$/) do
  @trackable = Institution.where(:name => @tempInstitution.name).first
  @trackable.should_not be_nil
end

Then(/^they should be on the institutions page$/) do
  expect(page).to have_content(@trackable.name)
end

When(/^they submit invalid institution information$/) do
  click_button "Create Institution"
end

Then(/^they should be on the new institutions page$/) do
  expect(page).to have_content("New institution")
end
Then(/^the Director should be added to the institution$/) do
  InstitutionMembership.where(:memberable => current_user).first.should_not be_nil
end




