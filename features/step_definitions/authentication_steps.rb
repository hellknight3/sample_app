Given(/^(?:a|an) (.*?) is logged in$/) do |userType|
  @user = FactoryGirl.create("user#{userType}")
  sign_in @user
end

Then(/^they should be on the signin page$/) do
  expect(page).to have_content("Sign in")
end
Given(/^the user logs out$/) do
  sign_out
end


