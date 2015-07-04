Then(/^a log entry with action (.*?) should be generated$/) do |action|
  Activity.where("user_id=#{current_user.id} AND trackable_type='#{@trackable.class}' AND Trackable_id=#{@trackable.id} AND action = '#{action.upcase}'").first.should_not be_nil
end 

Then(/^a log entry of the changes should be generated$/) do
    pending # Write code here that turns the phrase above into concrete actions
end

