require 'spec_helper'

describe Pool do

	#create pool object name pool
	before { @pool = create(:pool)}
	#check variable are responding 
	subject {@pool}
	it {should respond_to(:name)}
	it {should respond_to(:specialization)}
	it {should respond_to(:description)}
	it {should respond_to(:institution)}
    it {should respond_to(:appointment_memberships)}
    it {should respond_to(:appointments)}
    it {should have_many(:appointment_memberships)}
    it {should have_many(:appointments)}
    it {should have_many(:users)}
    it {should have_many(:permissions)}
    
	#check is pool object can be created
	it "has a valid factory" do
		#check we can create a pool
		create(:pool).should be_valid
	end
	
	#check name is not void
	it "name is not blank" do
		pool = create(:pool)#create pool
		#check attributes are not blank
		pool.name.should_not be_blank	
	end
	
	#check specialization is not blank
	it "specialization is not blank" do
		pool = create(:pool)#create pool
		#check attributes are not blank
		pool.specialization.should_not be_blank
	end
	#check description is not void
	it "describe is not blank" do
		pool = create(:pool)#create pool
		pool.description.should_not be_blank
	end
	#check institution is not blank
	it "institution is not blank" do
		pool = create(:pool)#create pool
		#check attributes are not blank
		pool.institution.should_not be_blank
	end
		
	#check name cannot be void
	it"should not accept nil name" do
		#check name cannot be nil
		build(:pool, name: nil).should_not be_valid
	end
	#check specialization cannot be nil
	it"should not accept nil specialization" do
		#check specialization cannot be nil
		build(:pool, specialization: nil).should_not be_valid
	end
	#check institution cannot be nil
	it"should not accept nil institution" do
		#check institution cannot be nil
		build(:pool, institution: nil).should_not be_valid
	end
	#check description cannot be nil
	it"should not accept nil description" do
		#check description cannot be nil
		build(:pool, description: nil).should_not be_valid
	end
	
	#check has_many relationship
	it "should have many users" do
		pool = create(:pool)
		pool.should have_many(:users)
	end
end
