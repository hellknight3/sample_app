Given(/^there have been some (.*?) activities$/) do |model|
  @activeModel=FactoryGirl.create(model.to_sym)
  @tempUser = FactoryGirl.create(:userDoctor)
  @activity=Activity.create(:user => current_user,:trackable => @activeModel,:action => "CREATE")
end

When(/^they view the (.*?) activities index$/) do |model|
  visit user_activities_path(current_user)
end

Then(/^they should see the recent (.*?) activities$/) do |model|
  expect(page).to have_content(@activity.user.name)
  expect(page).to have_content(@activity.action)
  expect(page).to have_content(@activity.created_at)

  expect(page).to have_content(@activity.trackable.name)
end

