require 'spec_helper'

describe User do
	#check patient object is created
	it "has a valid factory" do
		create(:patient).should be_valid
	end
	#check patient internal is an user object
	it "is a user" do 
		person = create(:patient)
		person.user.should be_an(User)
	end 
	#check patient doesnt have invalid name
	it "it is invalid without a name" do 
		person = create(:patient)
		person.user.name.should_not be_blank
	end 
	#check patient pw is valid
	it "it is invalid without a pw" do 
		person = create(:patient)
		person.user.password.should_not be_blank
	end 
	#check patient pwconfir is not empty
	it "check pwconfirm is not empty" do 
		person = create(:patient)
		person.user.password_confirmation.should_not be_blank
	end 
	#check email is not empty
	it "it is invalid without a email" do 
		person = create(:patient)
		person.user.email.should_not be_blank
	end 
end