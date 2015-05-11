require 'spec_helper'

describe User do
	#check that a doctor object can be created
	it "has a valid factory" do
		create(:doctor).should be_valid
	end
	#check object type
	it "it is a doctor object" do 
		person = create(:doctor)
		person.user.should be_an(User)
	end 
	#check name is not blank
	it "it is invalid without a name" do 
		person = create(:doctor)
		person.user.name.should_not be_blank
	end 
	#check pw is not empty
	it "it is invalid without a pw" do 
		person = create(:doctor)
		person.user.password.should_not be_blank
	end 
	#check pwconfirm is not empty
	it "it is invalid without a pwconfirm" do 
		person = create(:doctor)
		person.user.password_confirmation.should_not be_blank
	end 
	#check email is not empty
	it "it is invalid without an email" do 
		person = create(:doctor)
		person.user.email.should_not be_blank
	end 
end