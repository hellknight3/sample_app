require 'spec_helper'

describe Appointment do
	before { @appoint = create(:appointment)}
	
	#check object responds to its attributes
	subject{@appoint}
	it{should respond_to(description)}
	it{should respond_to(name)}	

	#check answer object can be created
	it "has a valid factory" do
		create(:appointment).should be_valid
	
	end 
	
	#check name cannot be nil
	it "should not have nil text" do
		build(:appointment, name: nil).should_not be_valid
	end
	
	#check description cannot be nil
	it "should not have nil text" do
		build(:appointment, description: nil).should_not be_valid
	end
	
end