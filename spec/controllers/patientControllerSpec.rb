require 'spec_helper'


#RSpec.describe User do
describe PatientsController, type: :controller do
	before (:each) do 
		@patient = FactoryGirl.create(:patient)
		sign_in  @patient
		controller.current_user = @patient.user
	end 
	
	it "should have a current_user" do
	 	expect(controller.current_user).to_not be_nil
  	end

	it "patients views their profile" do
		puts controller.current_user.id  
		get :show, {'id' => @patient.id}, {'user_id' => 1}
		# expect(assigns[:patients].id).to eq @patient.id
		expect(response).to be_success
	end
	
	it "should redirect properly" do 
		get :show, {'id'=> @patient.id}
		expect(response).to render_template :show
	end
	
	it "shouldnt be able to create a new user" do
		get :new
		expect(flash[:notice]).to eq("You do not have permission to do that.")
	end
	
	it "should fails to create patient and redirect to sign in" do 
		get :new
		expect(response).to render_template signin_url
	end

	it "patient shouldnt be able to create new patients" do 
		get :create
                expect(flash[:notice]).to eq("You do not have permission to do that.")	
	end 
	
	it "should edit patients name" do
		get :edit, {'id' => @patient.id }
		expect(assigns(:patient)).to eq(@patient)
	end

	it "should update patient" do
		puts @patient.user.name
		put :update, id: @patient.id, user: FactoryGirl.attributes_for(:user, name:"Bob", email:"something@gmail.com", password:"barfoo",password_confirmation:"barfoo")
	 	puts @patient.user.name	
		expect(response).to be_success	
		assert_equal "Bob", assigns(:patient).user.name
		assert_equal "something@gmail.com", assigns(:patient).user.email
		assert_equal "barfoo",  assigns(:password).user.password
	end

	it "shouldnt update only the patient name " do 
		put :update, id: @patient.id, user: FactoryGirl.attributes_for(:user, name: "Lisa")
		assert_equal "Lisa", assigns(:patient).user.name
	end
	
	it "shouldnt update only the patient name " do
                put :update, id: @patient.id, user: FactoryGirl.attributes_for(:user, email: "this@gmail.com")
                assert_equal "this@gmail.com", assigns(:patient).user.email
        end

	it "shouldnt update with invalid email" do
		put :update, id: @patient.id, user: FactoryGirl.attributes_for(:user, email: "this@gmailcom")
                assert_not_equal "this@gmailcom", assigns(:patient).user.name
	end 

	it"shouldnt update the pw" do
		put :update, id: @patient.id, user: FactoryGirl.attributes_for(:user, password: "barfoo", password_confirmation: "barfooo")
		expect(responce).to_not be_sucess
		assert_not_equal "barfoo", assigns(:patient).user.password
		assert_not_equal "barfooo", assigns(:patient).user.password

	end
end
