require 'spec_helper'

describe Message do
	before { @msg = create(:message)}
	
	#check object responds to its attributes
	subject{@msg}
	it{should respond_to(message)}	

	#check answer object can be created
	it "has a valid factory" do
		create(:message).should be_valid
	
	end 
	
	#check message cannot be nil
	it "should not have nil text" do
		build(:message, message: nil).should_not be_valid
	end
	
end