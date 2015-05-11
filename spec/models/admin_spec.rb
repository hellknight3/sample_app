require 'spec_helper'

describe User do
	#check admin object can be created
	it "has a valid factory" do
		create(:admin).should be_valid
	end
	#check admin internals are of type user
	it "it should contain a type user" do 
		person = create(:admin)
		person.user.should be_an(User)
	end 
	#check name is not empty
	it "it is invalid without a name" do 
		person = create(:admin)
		person.user.name.should_not be_blank
	end 
	#check pw is not empty
	it "it is invalid without a pw" do 
		person = create(:admin)
		person.user.password.should_not be_blank
	end 
	#check pwconf is not empty
	it "it is invalid without a pwConf" do 
		person = create(:admin)
		person.user.password_confirmation.should_not be_blank
	end 
	#check email is not empty
	it "it is invalid without an email" do 
		person = create(:admin)
		person.user.email.should_not be_blank
	end 
end