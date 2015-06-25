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
    it ""
      
  end
end

