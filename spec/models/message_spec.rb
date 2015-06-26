require 'spec_helper'

describe Message do
  it {should respond_to(:message)}
  it {should respond_to(:messageable)}
  it {should respond_to(:user)}

  it "needs a sender" do
   build(:directMessage, user: nil).should_not be_valid
#   expect(@message.save).to_not be_success
  end
  it "needs to have a message" do
    FactoryGirl.build(:directMessage, :message => nil).should_not be_valid
  end
  it "needs to have a recipient" do
      FactoryGirl.build(:directMessage, :messageable => nil).should_not be_valid
  end
  it "should be able to be created to a user" do
    FactoryGirl.build(:directMessage).should be_valid
  end
  it "should be able to be sent to an appointment" do
    FactoryGirl.build(:groupMessage).should be_valid
  end
  it "should not be sent to self" do
    @user = FactoryGirl.create(:user)
    @message = FactoryGirl.build(:directMessage, :user => @user,:messageable => @user).should_not be_valid
  end
end
