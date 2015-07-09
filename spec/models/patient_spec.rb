require 'spec_helper'

describe Patient do
	#check patient object is created
	it "has a valid factory" do
		create(:userPatient).should be_valid
	end
    it {should respond_to(:emergencyContact)}
    
    it {should respond_to(:emergencyPhoneNumber)}
    it {should respond_to(:familyDoctor)}
    it {should respond_to(:dateOfBirth)}
    it {should respond_to(:healthCardNumber)}
    it {should respond_to(:phoneNumber)}
    it {should respond_to(:weight)}
    it {should respond_to(:height)}
    it {should respond_to(:currentMedication)}
    it {should respond_to(:currentIssue)}
    it {should have_many(:doctors)}
    it {should have_many(:doc_relationships)}
    it {should have_one(:user)}
    
    before{@patient=FactoryGirl.build(:userPatient).profile}
=begin
	#check patient internal is an user object
	it "is a user" do 
		@user.should be_an(User)
	end 
	#check patient doesnt have invalid name
	it "is invalid without a name" do 
		@user.name.should_not be_blank
	end 
	#check patient pw is valid
	it "is invalid without a pw" do 
		@user.password.should_not be_blank
	end 
	#check patient pwconfir is not empty
	it "check pwconfirm is not empty" do 
		@user.password_confirmation.should_not be_blank
	end 
	#check email is not empty
	it "is invalid without a email" do 
		@user.email.should_not be_blank
	end 
=end

    it "should have an emergency contact" do
      @patient.emergencyContact=nil
      @patient.should_not be_valid
    end
    it "should have an emergency phone number" do
      @patient.emergencyPhoneNumber=nil
      @patient.should_not be_valid
    end
    it "should have a family doctor" do
      @patient.familyDoctor=nil
      @patient.should_not be_valid
    end
    
    it "should have a phone number" do
      @patient.phoneNumber=nil
      @patient.should_not be_valid
    end
    it "should have a weight" do
      @patient.weight=nil
      @patient.should_not be_valid
    end
    it "should have a height" do
      @patient.height=nil
      @patient.should_not be_valid
    end
    
    
end
