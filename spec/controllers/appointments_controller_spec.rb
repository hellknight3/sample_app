require 'spec_helper'

describe AppointmentsController, type: :controller do

  describe "GET #index" do
  before(:each) do
    @patient = FactoryGirl.create(:patient)
    sign_in @patient
    controller.current_user = @patient.user
  end
    it "should have route" do
      get :index
      expect(response).to be_success
    end
    it "should have logged in user" do
      expect(controller.current_user).to_not be_nil 

    end
   
  end
  describe "CREATE #index" do
    it "should succeed for a doctor" do
      @doctor = FactoryGirl.create(:doctor)
      sign_in @doctor
      controller.current_user = @doctor.user
      get :create, {:appointment => {:description => "test",:name => "test"}}
      expect(response).to be_success

    end
    it "should not succeed for a patient" do
      @user = FactoryGirl.create(:patient)
      sign_in @user
      controller.current_user = @user.user
      get :create, {:appointment => {:description => "test",:name => "test"}}
      expect(response).to_not be_success


    end
    

  end

end
private


