require 'spec_helper'

describe Pool do
	#create pool object name pool
	before { @pool = create(:pool)}
	#check variable are responding 
	subject {@user}
	it { should respond_to(:name)}
	it { should respond_to(:specialization)}
	it { should respond_to(:discription)}
	it {should respond_to(:institution)}

	#check is pool object can be created
	it "has a valid factory" do
		#check we can create a pool
		create(:pool).should be_valid
	end
	
	it "attributes are not blank" do
		pool = create(:pool)#create pool
		#check attributes are not blank
		pool.name.should_not be_blank	
	end
	it "attributes are not blank" do
		pool = create(:pool)#create pool
		#check attributes are not blank
		pool.specialization.should_not be_blank
	end
	it "attributes are not blank" do
		pool = create(:pool)#create pool
		pool.name.should_not be_blank
		pool.describe.should_not be_blank
	end
	it "attributes are not blank" do
		pool = create(:pool)#create pool
		#check attributes are not blank
		pool.institution.should_not be_blank
	end
		
	it"should not accept nil name" do
		#check name cannot be nil
		build(:user, name: nil).should_not be_valid
	end
	it"should not accept nil specialization" do
		#check specialization cannot be nil
		build(:user, specialization: nil).should_not be_valid
	end
	it"should not accept nil institution" do
		#check institution cannot be nil
		build(:user, institution: nil).should_not be_valid
	end
	it"should not accept nil description" do
		#check description cannot be nil
		build(:user, description: nil).should_not be_valid
	end
end