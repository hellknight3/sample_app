require 'spec_helper'

describe MessagesController, type: :controller do
  before(:each) do
    @message = FactoryGirl.create(:message)
    @user = @message.user
    sign_in @user
    controller.current_user = @user
  end
  context "index" do

    it "should have all associated users"
    it "should not have duplicate users"
    it "should list all current conversations"
      
  end
  context "new" do
    it "should have the history of the conversation for an appointment" 
    it "should have the history of the conversation for an user" 
    it "should be able to send to an appointment"
    it "should be able to send to a user"

  end
end

