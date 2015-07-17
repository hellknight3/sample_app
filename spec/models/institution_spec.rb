require 'spec_helper'

describe Institution do
    it{should respond_to(:name)}
    it{should respond_to(:description)}
    it{should have_many(:pools)}
    it{should have_many(:users)}
	it "has a valid factory" do
		create(:institution).should be_valid
	end
    it "should have a name" do
      FactoryGirl.build(:institution, :name => nil).should_not be_valid
    end
    it "should have a description" do
      FactoryGirl.build(:institution, :description => nil).should_not be_valid
    end
    
end
