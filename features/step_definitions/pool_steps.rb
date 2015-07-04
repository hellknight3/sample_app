Given(/^(?:the (?:doctor|patient|admin)|they) visits the new pools path$/) do
  visit new_pool_path
end
Given(/^they have (\d+) pool(?:|s)$/) do |numPools|
  numPools.to_i.times do
    @trackable= FactoryGirl.create(:pool)
    Permission.create(:user => current_user,:pool => @trackable) 

  end

end
Given(/^there are (\d+) pool(?:|s)$/) do |numPools|
  numPools.to_i.times do 
    FactoryGirl.create(:pool)
  end
end
Given(/^they visit the edit pools path$/) do
  visit edit_pool_path(@trackable)
end

When(/^they submit a valid pool$/) do
  fill_in "Name", :with => "test pool"
  fill_in "Description",:with => "test valid pool"
  fill_in "Specialization",:with => "test specialization"
  click_button "Create Pool"
end
When(/^they submit an invalid pool$/) do
  click_button "Create Pool"
end
When(/^they visit the (.*?) pools index$/) do |passedParam|
  visit pools_path({:pools => passedParam})
end
When(/^they submit valid updates to the pool$/) do
  fill_in "Name", :with => "new name"
  click_button "Update Pool"
end



Then(/^a pool should be created$/) do
  @trackable = Pool.where("Name = 'test pool'").first
  @trackable.description.should eq "test valid pool"
end
Then(/^they should be on the new pools page$/) do
  expect(page).to have_content("Create new pool") 
end
Then(/^they should be on the pools index page$/) do
  expect(page).to have_content("My Pools")
end
Then(/^they should see their (\d+) pool(?:|s)$/) do |numPools|
  @pools=Pool.joins(:permissions).where("permissions.user_id = #{current_user.id}")
  @results=@pools.count.should eq numPools.to_i
  @pools.each do |pool|
    @resutls &&= expect(page).to have_content(pool.name)
  end
end
Then(/^they should see (\d+) pool(?:|s)$/) do |arg1|
  @result=true
  Pool.all.each do |pool|
    @result &&=expect(page).to have_content(pool.name)
  end
end

Then(/^they should not be able to edit$/) do
  expect(page).to_not have_content("Edit")
end
Then(/^the pool should be changed$/) do
  Pool.find(@trackable).name.should eq "new name"
end


