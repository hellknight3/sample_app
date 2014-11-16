require 'spec_helper'

describe User do
	it "has a valid factory" do
		create(:admin).should be_valid
	end
	it "it is invalid without a name" do 
		person = create(:admin)
		person.user.should be_an(User)
	end 
	it "it is invalid without a name" do 
		person = create(:admin)
		person.user.name.should_not be_blank
	end 
	it "it is invalid without a name" do 
		person = create(:admin)
		person.user.password.should_not be_blank
	end 
	it "it is invalid without a name" do 
		person = create(:admin)
		person.user.password_confirmation.should_not be_blank
	end 
	it "it is invalid without a name" do 
		person = create(:admin)
		person.user.email.should_not be_blank
	end 
end