When(/^they try to create a institution$/) do
  visit new_institution_path
end
Given(/^they visit the new institution path$/) do
  visit new_institution_path
end

When(/^they submit valid (.*?) institution information$/) do |function|
  @tempInstitution = FactoryGirl.build(:institution)
  fill_in "Name", :with =>  @tempInstitution.name
  fill_in "Description", :with => @tempInstitution.description
  if function== "updated"
    click_button "Update Institution"
  else
    click_button "Create Institution"
  end
end

Then(/^a institution should be created$/) do
  @trackable = Institution.where(:name => @tempInstitution.name).first
  @trackable.should_not be_nil
end

Then(/^they should be on the institutions page$/) do
  expect(page).to have_content(@trackable.name)
end

When(/^they submit invalid institution information$/) do
  click_button "Create Institution"
end

Then(/^they should be on the new institutions page$/) do
  expect(page).to have_content("New institution")
end
Then(/^the Director should be added to the institution$/) do
  InstitutionMembership.where(:memberable => current_user).first.should_not be_nil
end
Given(/^they have an institution$/) do
  @institution=FactoryGirl.create(:institution)
  InstitutionMembership.create(:institution => @institution,:memberable => current_user)
end
Given(/^the institution has (\d+) pools$/) do |numPools|
  numPools.to_i.times do
    @pool=FactoryGirl.create(:pool)
  InstitutionMembership.create(:institution => @institution,:memberable => @pool)
  end
end

When(/^they visit the institutions show page$/) do
  visit institution_path(@institution)
end

Then(/^they should see institutions name$/) do
  expect(page).to have_content(@institution.name)
  expect(page).to have_content(@institution.description)

end

Then(/^they should see institutions pools$/) do
  @institution.pools.each do |pool|
    expect(page).to have_content(pool.name)
  end
end
Then(/^they should see a news bulletin$/) do
  expect(page).to have_content("News Bulletin")
end

Then(/^they should be able to add a news bulletin$/) do
  #
  pending
  #expect(page).to have_button()
end
Given(/^they visit the edit institutions page$/) do
  @trackable=@institution
  visit edit_institution_path(@trackable)
end

Then(/^the institution should be changed$/) do
  @institution= Institution.find(@trackable)
  @tempInstitution.name.should eq @institution.name

  @tempInstitution.description.should eq @institution.description
end

Then(/^they should be on the institutions show page$/) do
  expect(page).to have_content("News Bulletin")
end

Then(/^they should have an institution$/) do
  @trackable.user.institutions.empty?.should be_false 
end

