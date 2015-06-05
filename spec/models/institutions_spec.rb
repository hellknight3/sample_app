require 'spec_helper'

describe Institution do
	
	before{@institution = create(:institution)}
	subject{@institution}
	it {should respond_to(:name)}
	it {should respond_to(:description)}

	it "should have a valid factory" do
		create(:institution).should be_valid
	end

	it "name should not be blank" do
		ins = create(:institution)
		ins.name.should_not be_blank
	end

	it " shoudl not allow name to be void" do
		 build(:institution, name: nil).should_not be_valid
	end

	it "should have many pools" do
		ins = create(:institution)
		ins.should have_many(:pools)	
	end

end
