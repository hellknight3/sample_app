#contains both admin and director functions
Given(/^the visit their edit admin path$/) do
  visit edit_admin_path(current_user.profile_id)
end

When(/^they submit valid changes for a director$/) do
  @changes=FactoryGirl.build(:userDirector)
  fill_in "Name",:with => @changes.name
  fill_in "Email",:with => @changes.email
  fill_in "Old password",:with => "foobar" 
  click_button "Update Profile"
end

Then(/^the director should be updated$/) do
  User.find(current_user).name.should eq @changes.name
  User.find(current_user).email.should eq @changes.email
end

Then(/^they should be on their profile page$/) do
    pending # Write code here that turns the phrase above into concrete actions
end

