Given(/^they visit a new patient path$/) do
  visit new_patient_path
end

When(/^they submit valid patient information$/) do
  @patient=FactoryGirl.build(:userPatient)
  fill_in "Name",:with => @patient.name
  fill_in "Email",:with =>@patient.email 
  fill_in "Emergencycontact",:with => @patient.profile.emergencyContact
  fill_in "Emergencyphonenumber",:with => @patient.profile.emergencyPhoneNumber
  fill_in "Familydoctor",:with => @patient.profile.familyDoctor
  fill_in "Phonenumber",:with => @patient.profile.phoneNumber
  fill_in "Weight", :with => @patient.profile.weight
  fill_in "Height", :with => @patient.profile.height
  fill_in "Password", :with => "foobar"
  fill_in "Confirmation", :with => "foobar"
  click_button "Create Patient"
end

Then(/^a patient should be created$/) do
  @trackable=Patient.joins(:user).where("users.email = '#{@patient.email}'").first
  @trackable.should_not be_nil
end

Then(/^they should receive a success message$/) do
  expect(page).to have_selector('div.alert.alert-success')
end

Then(/^they should be on their home page$/) do
  expect(page).to have_selector("img.gravatar")
end

Given(/^a Patient exists$/) do
  @patient=FactoryGirl.create(:userPatient)
end

When(/^they edit a patient setting (.*?)$/) do |setting|
  if setting == "doctor"
    visit edit_user_path(@patient,{:settings => "AvailableDocs"})
  elsif setting == "pool"
    visit edit_user_path(@patient,{:settings => "AdjustPools"})
  end
end

Then(/^they should be able to (.*?) doctors$/) do |action|
  expect(page).to have_selector("input[type=submit][value='#{action} doctor']")
end

Given(/^a Doctor exists$/) do
  @doctor=FactoryGirl.create(:userDoctor)
end

Given(/^the doctor has the same pool$/) do
  Permission.create(:user => @doctor,:pool => @trackable)
end

When(/^the patient updates their profile$/) do
  fill_in "Name", :with => "foobar"
  fill_in "Old password", :with => "foobar"
  click_button "Update Profile"
end

Then(/^the patient should be changed$/) do
  User.find(current_user.id).name.should eq "foobar"
end
Given(/^a Patient exist$/) do
  @patient=FactoryGirl.create(:userPatient)
end

When(/^they edit a patient$/) do
  visit edit_patient_path(@patient.profile_id)
end


