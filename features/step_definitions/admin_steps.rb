#contains both admin and director functions
Given(/^the visit their edit admin path$/) do
  visit edit_admin_path(current_user.profile_id)
end
When(/^they visit the new admin path$/) do
   visit new_admin_path 
end

When(/^they submit valid changes for a director$/) do
  @changes=FactoryGirl.build(:userDirector)
  fill_in "Name",:with => @changes.name
  fill_in "Email",:with => @changes.email
  fill_in "Old password",:with => "foobar" 
  click_button "Update Profile"
end
When(/^they submit valid changes for a admin$/) do
  @changes=FactoryGirl.build(:userAdmin)
  fill_in "Name",:with => @changes.name
  fill_in "Email",:with => @changes.email
  fill_in "Old password",:with => "foobar" 
  click_button "Update Profile"
end
When(/^they submit valid admin information$/) do
  @newAdmin=FactoryGirl.build(:userAdmin)
  fill_in "Name",:with => @newAdmin.name
  fill_in "Email",:with => @newAdmin.email
  fill_in "Password",:with => "foobar" 
  fill_in "Confirmation",:with => "foobar"
  click_button "Create Admin"
end

Then(/^the director should be updated$/) do
  User.find(current_user).name.should eq @changes.name
  User.find(current_user).email.should eq @changes.email
end
Then(/^the admin should be updated$/) do
  User.find(current_user).name.should eq @changes.name
  User.find(current_user).email.should eq @changes.email
end
When(/^they try to edit (?:another|an) admin$/) do
  visit edit_admin_path(@admin.profile)
end

Given(/^a Director exists$/) do
  @director = FactoryGirl.create(:userDirector)
end
Given(/^(?:a|an) Admin exists$/) do
  @admin = FactoryGirl.create(:userAdmin)
end
When(/^they try to edit (?:a|another) director$/) do
  visit edit_admin_path(@director.profile)
end
Then(/^the admin should be created$/) do
  @admin=User.where("Name='#{@newAdmin.name}'").first
  @admin.should_not be_nil
  @trackable=@admin.profile
end

