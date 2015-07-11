#-----------given----------
Given(/^they visit the new doctor path$/) do
  visit new_doctor_path
end

Given(/^(?:the (?:Admin|Patient|Doctor|Director)|they) visit(?:|s) the new doctors path$/) do
  visit new_doctor_path
end

Given(/^a Doctor exists$/) do
  @doctor=FactoryGirl.create(:userDoctor).profile
end

Given(/^the Doctor has a patient$/) do
  DocRelationship.create(:doctor => current_user.profile,:patient => @patient)
end

Given(/^a doctor has a patient (.*?)$/) do |acceptance_status|
  if acceptance_status == "accepted"
    DocRelationship.create(:doctor => current_user.profile, :patient => @patient, :accepted => true)
  elsif acceptance_status == "rejected"
    DocRelationship.create(:doctor => current_user.profile, :patient => @patient, :accepted => false)
  elsif acceptance_status == "pending"
    DocRelationship.create(:doctor => current_user.profile, :patient => @patient, :accepted => nil)
  end
end

#-----------when----------

When(/^they submit valid doctor information$/) do
  @doctor=FactoryGirl.build(:userDoctor)
  fill_in "Name",:with => @doctor.name 
  fill_in "Email",:with => @doctor.email
  fill_in "Password",:with => "foobar"
  fill_in "Confirmation",:with => "foobar"
  click_button "Create Doctor"
end

When(/^the doctor views their (.*?) patients$/) do |acceptance_status|
  visit doctors_path({:id => current_user.profile_id,:patient_status => acceptance_status})
end

When(/^they view a doctors patients$/) do
  visit doctors_path({:id => @doctor.id})
end
#-----------then----------

Then(/^they should be on the user index page (.*?)$/) do |user_type|
  expect(page).to have_content("Listing #{user_type}")
  expect(page).to have_content(@doctor.name)
end

Then(/^a doctor should be created$/) do
  @user = User.where("Name='#{@doctor.name}'").first
  @user.should_not be_nil
  @trackable=@user.profile
end

Then(/^they should see his (?:accepted|pending|rejected) patient(?:|s)$/) do
  expect(page).to have_content(Patient.find(@patient).user.name)
end


