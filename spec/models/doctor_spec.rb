require 'spec_helper'

describe Doctor do
	#check that a doctor object can be created
    it{should have_many(:activities)} 

	it "has a valid factory" do
		create(:doctor).should be_valid
	end
    before {@doctor = FactoryGirl.create(:userDoctor).profile}
	#check object type
	it "it is a doctor object" do 
		@doctor.user.should be_an(User)
	end 
	#check name is not blank
	it "it is invalid without a name" do 
		@doctor.user.name.should_not be_blank
	end 
	#check pw is not empty
	it "it is invalid without a pw" do 
		@doctor.user.password.should_not be_blank
	end 
	#check pwconfirm is not empty
	it "it is invalid without a pwconfirm" do 
		@doctor.user.password_confirmation.should_not be_blank
	end 
	#check email is not empty
	it "it is invalid without an email" do 
		@doctor.user.email.should_not be_blank
	end 
end
