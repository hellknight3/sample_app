Given(/^(?:the (?:doctor|patient|admin)|they) visits? the new appointments path$/) do
  if current_user.profile_type == "Doctor"
    visit appointments_path
    click_link "New Appointment"
  else
    visit new_appointment_path
  end
end
Given(/^they have an appointment$/) do
  @trackable = FactoryGirl.create(:appointment)
  @message = FactoryGirl.create(:groupMessage,:user => @user,:messageable => @trackable)
end
Given(/^they have an appointment with (\d*) participants$/) do |participants|
  @trackable = FactoryGirl.create(:appointment)
  @message = FactoryGirl.create(:groupMessage,:user => @user,:messageable => @trackable)
  participants.to_i.times do
    @user = FactoryGirl.create(:userPatient)
    @message = FactoryGirl.create(:groupMessage,:user => @user,:messageable => @trackable)
  end
  if(current_user.profile_type != "Doctor")
    @user = FactoryGirl.create(:userDoctor)
    @message = FactoryGirl.create(:groupMessage,:user => @user,:messageable => @trackable)
  end
end

Given(/^they visit the edit appointments path$/) do
  visit edit_appointment_path(@trackable.id)
end

Given(/^they have (\d+) (.*?) appointments$/) do |number,status|
    @endtime=nil
    @startTime = DateTime.now.to_date
  if status == "Closed"
    @endtime=DateTime.now.to_date
  elsif status == "Future"
    @startTime-=5
  end
  number.to_i.times do 
    @trackable = FactoryGirl.create(:appointment,:start_time => @startTime,:end_time => @endTime)
    @message = FactoryGirl.create(:groupMessage,:user => @user,:messageable => @trackable)
  end
  
end

When(/^they submit a valid appointment$/) do
  fill_in "Description", :with =>  "testValidAppointment"
  fill_in "Name", :with => "test"
  #fill_in "Start time", :with => Time.now
  click_button "Create Appointment"
  
end

When(/^they submit an invalid appointment$/) do
  click_button "Create Appointment"
end

When(/^they submit a change to the appointment$/) do
  fill_in "Name", :with => "something different"
  click_button "Update Appointment"
end
When(/^they submit invalid changes to the appointment$/) do
  fill_in "Description", :with => nil
  click_button "Update Appointment"
end

When(/^they view their (.*?) appointments$/) do |status|
  visit appointments_path({:appointment => status})
end

When(/^they view the appointment$/) do
  visit appointments_path(@trackable)
end

When(/^they view the appointment messages$/) do
  visit new_message_path({:messageable_id => @trackable.id, :messageable_type => "Appointment"})
end

Then(/^the appointment should be changed$/) do
  Appointment.where("Name = 'something different'").first.id.should eq @trackable.id
end
Then(/^they should be on the edit appointments page$/) do
  expect(page).to have_content("Edit #{@trackable.name}")
end
Then(/^they should see their (\d+) (.*?) appointments$/) do |number, status|
  @appointments = Message.where("user_id=#{@user.id}").joins("inner join appointments on messages.messageable_id = appointments.id").select(:messageable_id,:messageable_type,:user_id,:name).distinct
  @result = expect(@appointments.count).to eq number.to_i
  @appointments.each do |app|
    @result &&= expect(page).to have_content(app.name)
  end
  @result 
end
Then(/^they should see the doctor who is participating$/) do
  @messages=Message.where(:messageable => @trackable)
  @messages.each do |message|
  #@contain.each do |user|
    if(message.user.profile_type == "Doctor")
      expect(page).to have_content(message.user.name)
    end
  #end
   
  end
end

Then(/^they should not see the patients names who are participating$/) do
  @messages=Message.where(:messageable => @trackable)
  @messages.each do |message|
  if(message.user.profile_type != "Doctor" && message.user.name != current_user.name)
      expect(page).to_not have_content(message.user.name)
    end
  end
end


Then(/^they should see the appointments pools$/) do
    pending # Write code here that turns the phrase above into concrete actions
end

Then(/^they should see who is participating in the appointment$/) do
  @messages=Message.where(:messageable => @trackable)
  @messages.each do |message|
    expect(page).to have_content(message.user.name)  
  end
end

Then(/^they should see the appointments properies$/) do
    pending # Write code here that turns the phrase above into concrete actions
end

Then(/^they should be redirected to their current appointments page$/) do
  expect(page).to have_content("My Appointments")
end
Then(/^they should be on the new appointments page$/) do
  expect(page).to have_content("Create New Appointment")
end
Then(/^an appointment should be created$/) do
  wait_for_ajax
  @trackable=Appointment.where("Name = 'test'").first
  @trackable.description.should eq "testValidAppointment"
end
Then(/^they should be on they appointments page$/) do
  expect(page).to have_content("Conversation history")
end

