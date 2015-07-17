#----------------Given-----------------
Given(/^there have been some (.*?) activities$/) do |model|
  @activeModel=FactoryGirl.create(model.to_sym)
  @tempUser = FactoryGirl.create(:userDoctor)
  @activity=Activity.create(:user => current_user,:trackable => @activeModel,:action => "CREATE")
end

Given(/^there have been some activities by a (.*?)$/) do |modelUser|
  @activeUser=FactoryGirl.create("user#{modelUser}")
  
end
#----------------When-----------------

When(/^they view the (.*?) activities index$/) do |model|
  visit user_activities_path(current_user)
end
Given(/^a Patient was previously logged in$/) do
  @previousUser=@patient
end

When(/^they view (?:an?|the) (.*?)'s activities$/) do |tracked_model|
  if tracked_model=="Patient"
    visit user_activities_path(@previousUser) 
  elsif tracked_model=="Doctor"
    visit user_activities_path(@previousUser) 
  elsif tracked_model=="Admin"
    visit user_activities_path(@previousUser) 
  elsif tracked_model=="Director"
    visit user_activities_path(@previousUser) 
  elsif tracked_model=="Pool"
    visit pool_activities_path(@trackable) 
  elsif tracked_model=="Appointment"
    visit appointment_activities_path(@trackable) 
  #elsif tracked_model=="User"
  #elsif tracked_model=="User"
  #elsif tracked_model=="User"
  end
end

#----------------Then-----------------
Then(/^they should see the recent activities$/) do
  expect(page).to have_content(@activity.user.name)
  expect(page).to have_content(@activity.action)
  expect(page).to have_content(@activity.created_at)
  if isProfile?(@activity.trackable_type)
    expect(page).to have_content(@activity.trackable.user.name)
  else
    expect(page).to have_content(@activity.trackable.name)
  end
end
Given(/^the (?:Doctor|Admin|Patient|Director) (.{3}.*?)s a (.*?)$/) do |action,trackedModel|
  #@doctor=FactoryGirl.create(trackedModel).profile
  @trackable = createTrackedModel(trackedModel)
  @previousUser=current_user
  @activity = Activity.create(:user => current_user,:trackable => @trackable,:action => action)
end

Then(/^they should see a (.*?) (.*?)d in Doctor's activities$/) do |tracked_model,action|

  expect(page).to have_content(@activity.user.name)  
  expect(page).to have_content(@activity.action)  

end
def createTrackedModel(trackedModel)
  if isProfile?(trackedModel) 
    FactoryGirl.create("user#{trackedModel}").profile
  else
    FactoryGirl.create(trackedModel)
  end
end
def isProfile?(string)
string == "Doctor" || string =="Admin" || string =="Patient"
end
