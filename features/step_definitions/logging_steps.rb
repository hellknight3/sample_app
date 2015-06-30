Then(/^a log entry with action (.*?) should be generated$/) do |action|
  Activity.where("user_id=#{current_user.id} AND trackable_type='#{@trackable.class}' AND Trackable_id=#{@trackable.id} AND action = '#{action.upcase}'").first.should_not be_nil
end 

