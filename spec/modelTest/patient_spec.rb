require 'spec_helper'

describe User do
	it "has a valid factory" do
		create(:patient).should be_valid
	end
	it "it is invalid without a name" do 
		person = create(:patient)
		person.user.should be_an(User)
	end 
	it "it is invalid without a name" do 
		person = create(:patient)
		person.user.name.should_not be_blank
	end 
	it "it is invalid without a name" do 
		person = create(:patient)
		person.user.password.should_not be_blank
	end 
	it "it is invalid without a name" do 
		person = create(:patient)
		person.user.password_confirmation.should_not be_blank
	end 
	it "it is invalid without a name" do 
		person = create(:patient)
		person.user.email.should_not be_blank
	end 
end