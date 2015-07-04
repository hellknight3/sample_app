Then(/^the admin should be in the pool$/) do
  Permission.where("pool_id=#{@trackable.id} and user_id=#{current_user.id}").first.should_not be_nil
end
