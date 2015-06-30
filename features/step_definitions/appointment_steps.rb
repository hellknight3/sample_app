
When(/^they submit a valid appointment$/) do
  fill_in "Description", :with =>  "testValidAppointment"
  fill_in "Name", :with => "test"
  #fill_in "Start time", :with => Time.now
  click_button "Create Appointment"
end
Then(/^an appointment should be created$/) do
  @trackable=Appointment.where("Name = 'test'").first
  @trackable.description.should eq "testValidAppointment"
end
Given(/^(?:the (?:doctor|patient|admin)|they) visit(?:|s) the new appointments path$/) do
  visit new_appointment_path
end

When(/^they submit an invalid appointment$/) do
  click_button "Create Appointment"
end
Then(/^they should be redirected to their current appointments page$/) do
  expect(page).to have_content("My Appointments")
end
Then(/^they should be on the new appointments page$/) do
  expect(page).to have_content("Create New Appointment")
end
Given(/^they have an appointment$/) do
  @trackable = FactoryGirl.create(:appointment)
  @message = FactoryGirl.create(:message,:user => @user,:messageable => @trackable)
end

Given(/^they visit the edit appointments path$/) do
  visit edit_appointment_path(@trackable.id)
end

When(/^they submit a change to the appointment$/) do
  fill_in "Name", :with => "something different"
  click_button "Update Appointment"
end

Then(/^the appointment should be changed$/) do
  Appointment.where("Name = 'something different'").first.id.should eq @trackable.id
end
When(/^they submit invalid changes to the appointment$/) do
  fill_in "Description", :with => nil
  click_button "Update Appointment"
end

Then(/^they should be on the edit appointments page$/) do
  expect(page).to have_content("Edit #{@trackable.name}")
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
    @message = FactoryGirl.create(:message,:user => @user,:messageable => @trackable)
  end
  
end

When(/^they view their (.*?) appointments$/) do |status|
  visit appointments_path({:appointment => status})
end

Then(/^they should see their (\d+) (.*?) appointments$/) do |number, status|
  @appointments = Message.where("user_id=#{@user.id}").joins("inner join appointments on messages.messageable_id = appointments.id").select(:messageable_id,:messageable_type,:user_id,:name).distinct
  @result = expect(@appointments.count).to eq number.to_i
  @appointments.each do |app|
    @result &&= expect(page).to have_content(app.name)
  end
  @result 
end


