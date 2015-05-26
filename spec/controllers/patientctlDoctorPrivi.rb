require 'spec_helper'

#test doctor access to a patients information
describe PatientsController, type: :controller do
	before(:each) do
		@patient = FactoryGirl.create(:patient)
		@doctor = FactoryGirl.create(:doctor)
		controller.current_user = @doctor.user
	end
#test show of a patient which hasnt been assigned to the doctor
	it "should not allow the doctor to view patient" do
		get :show, {'id' =>@doctor.id}, {'user_id'=> @patient.id}
		expect(response).to_not be_success
	end
#test new 
	it "should not be allowed to create a new patient" do
		get:new
		 expect(flash[:notice]).to eq("You do not have permission to do that.")
	end
# test create
	it "should not be able to access new" do
		get :create
		 expect(flash[:notice]).to eq("You do not have permission to do that.")
	end
#test edit
	it "should not allow doctor  to edit" do
		get :edit,{'id'=>@patient.id}
		expect(response).to_not be_success
	end
# test update
	it "should not be allowed to updat the patient" do
		puts :update, {'id' => @patient.id, 'patient' => {:weight=> 2} }
	#	expect(response).to_not be_success
		assert_not_equal 2, assigns(:patient).weight
	end
end
