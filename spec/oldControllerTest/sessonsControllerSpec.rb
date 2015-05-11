require 'spec_helper'

describe  SessionsController, type: :controller do

describe ":new" do
#doesnt do anything
end
describe ":create" do
	context "valid input" do
		it"login is a patient" do
		#	@user = create(:patient)
	#		expect{post :create, password: @user.user.password,email:@user.user.email}.to_not raise_error
		#	{name: "Joe", email: "me@gmail.com", password: "foobar", password_confirmation: "foobar"}}.to change(User, :count).by(1)
		end
		it "check redirect" do
			@user = create(:patient)
			puts @user.user.email
			puts session[:key]
			post :create, email: @user.user.email, session: session[:key]
#			password: @user.user.password,email:@user.user.email
			response.should redirect_to User
		end
	end 
	context "invalid input" do
	end 
end
describe ":destroy" do
end
end