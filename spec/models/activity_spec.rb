require 'spec_helper'

describe Activity do
  #pending "add some examples to (or delete) #{__FILE__}"
  # responds to action, 
 before { @activity = FactoryGirl.build(:activity)} 
  it {should respond_to(:action)}
  it {should respond_to(:message)}
  it {should respond_to(:trackable)}
  it {should respond_to(:user)}
  it {should belong_to(:user)}  
  it {should belong_to(:trackable)}  
  
  it "should have an action" do
    @activity.action = nil
    @activity.should_not be_valid 
  end
  it "should have a message" do
    @activity.message=nil
    @activity.should_not be_valid 
  end
  it "should have the object it is tracking" do
    @activity.trackable=nil
    @activity.should_not be_valid 
  end
  it "should have the user that performed the action" do
    @activity.user = nil
    @activity.should_not be_valid 
  end
  it "should be valid with factory" do
    @activity.should be_valid 
  end
end
