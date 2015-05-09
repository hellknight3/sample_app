require 'spec_helper'

describe DoctorsController, type: :controller do
	before(:each) do
		@doctor = FactoryGirl.create(:doctor)
		sign_in @doctor
		controller.current_user = @doctor.user
	end
	
#	index
	it "should have a current user" do
		expect(controller.current_user).to_not be_nil
	end

	it "should find their profile" do
		get :index, {'id' => @doctor.id}, {'user_id' => @doctor.id}
	#	expect(responce).to be_success
		assert_equal @doctor, assigns(:doctor)
	end

#	show
	it "should view their profile" do
		get :show, {'id' => @doctor.id}, {'user_id'=> @doctor.id}
		assert_equal @doctor, assigns(:doctor)
	end
	
	it "should beable to view other doctor profiles " do
		@doctor2 = FactoryGirl.create(:doctor)
		get :show, {'id' => @doctor2.id}, {'user_id' => @doctor.id}
		assert_equal @doctor2, assigns(:doctor)
	end	
#	new
	it "should not beable to create a new doctor" do
		get :new
		expect(response).to_not be_success	
	end

#	create
	it "should not be able to create" do
		get :create
		expect(response).to_not be_success
	end

#	edit
	it "should go to the edit pages" do
	   get :edit, {'id'=> @doctor.id}, {'user_id'=>@doctor.id}
	   assert_equal @doctor, assigns(:doctor)
	end

#	update
	it "update the doctors attributes" do
		put :update, id:@doctor, user:FactoryGirl.attributes_for(:user, name:"Bob", email:"something@gmail.com", password:"barfoo",password_confirmation:"barfoo")
	assert_equal "Bob", assigns(:doctor).user.name
	assert_equal "something@gmail.com", assigns(:email).user.email
	assert_equal "barfoo", assigns(:password).user.password
	end
	
	it "should only update the name" do
		put :update, id:@doctor, user:FactoryGirl.attributes_for(:user, name:"Bob")
        	assert_equal "Bob", assigns(:doctor).user.name
	end
	
	it "should only update the pw" do
		put :update, id: @doctor, user:FactoryGirl.attributes_for(:user,password: "barfoo", password_confirmation: "barfoo")
		assert_equal "barfoo", assigns(:doctor).user.password
	end
	
	it"shouldnt update the pw" do
		put :update, id: @doctor, user:FactoryGirl.attributes_for(:user,email: "somethinggmail.com")
                assert_not_equal "somethinggmail.com", assigns(:doctor).user.email
	end
	
	it "shouldnt update the pw"do
		  put :update, id: @doctor, user:FactoryGirl.attributes_for(:user,password: "barfoo", password_confirmation: "barf0oo")
                assert_not_equal "barfoo", assigns(:doctor).user.password
		assert_not_equal "barf0oo", assigns(:doctor).user.password_confirmation		
	end
end
