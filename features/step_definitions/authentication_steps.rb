Given(/^(?:a|an) (.*?) is logged in$/) do |userType|
  @user = FactoryGirl.create("user#{userType}")
  sign_in @user
end
