require 'spec_helper'
describe Appointment do
  it {should respond_to(:name)}
  it {should respond_to(:description)}
  it {should respond_to(:pools)}
  it {should respond_to(:appointment_memberships)}
  it {should respond_to(:start_time)}
  it {should respond_to(:end_time)}

  it "should have a description" do 
    FactoryGirl.build(:appointment,:description => nil).should_not be_valid
  end
  it "should have a name" do 
    FactoryGirl.build(:appointment,:name => nil).should_not be_valid
  end
  it "should have a start_time" do
    FactoryGirl.build(:appointment,:start_time=>nil).should_not be_valid
  end
  it "should be valid" do
    FactoryGirl.build(:appointment).should be_valid
  end
  it {should have_many(:activities)}
  it {should have_many(:messages)}
  it {should have_many(:users)}
  it {should have_many(:pools)}
  it {should have_many(:appointment_memberships)}
end
