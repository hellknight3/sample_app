Given(/^they visit the new doctor path$/) do
  visit new_doctor_path
end

When(/^they submit valid doctor information$/) do
  @doctor=FactoryGirl.build(:userDoctor)
  fill_in "Name",:with => @doctor.name 
  fill_in "Email",:with => @doctor.email
  fill_in "Password",:with => "foobar"
  fill_in "Confirmation",:with => "foobar"
  click_button "Create Doctor"
  
end

Then(/^a doctor should be created$/) do
  User.where("Name=#{@doctor}").first.should_not be_nil
end


Then(/^a log entry with the action create is generated$/) do
    pending # Write code here that turns the phrase above into concrete actions
end
Given(/^(?:the (?:Admin|Patient|Doctor|Director)|they) visit(?:|s) the new doctors path$/) do
  visit new_doctor_path
end

Then(/^they should be on the user index page (.*?)$/) do |user_type|
  expect(page).to have_content("Listing #{user_type}")
  expect(page).to have_content(@doctor.name)
end

