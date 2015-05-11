require 'spec_helper'

describe Answer do
	before { @answer = create(:answer)}
	
	#check object responds to its attributes
	subject{@answer}
	#it{should respond_to(question_id)}
	it{should respond_to(:response)}
#	it{should respond_to(user_id)}
	

	#check answer object can be created
	it "has a valid factory" do
		create(:answer).should be_valid
	end 
	
	#check responce cannot be nil
	it "should not have nil text" do
		build(:answer, response: nil).should_not be_valid
	end
	
	
end
