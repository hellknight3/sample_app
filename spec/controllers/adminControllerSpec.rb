require 'spec_helper'


#testing the AdminsController, type must be specified
describe AdminsController, type: :controller do
	#creates an admin, sign them in and set  them as a the current user 
	#before each test
	before (:each) do
		@admin = FactoryGirl.create(:admin)
		sign_in @admin
		controller.current_user = @admin.user
	end

	#check current user is not nil
	it "should have a current user" do
		expect(controller.current_user).to_not be_nil
	end
	
	#index
	it "shoud find the admins profile" do
		get :index, {'id' =>@admin.id}, {'user_id' => @admin.id}
		#check doctor foundis the proper admin
		assert_equal @admin, assigns(:admin)
	end
	
	#show
	it "should view their profile" do
		get :index, {'id'=> @admin.id}, {'user_id'=> @admin.id}
		#check if doctor is shown and is the proper doctor	
		assert_equal @admin, assigns(:admin)
	end
	
	it "should be able to view other admins profiles" do
		@admin2 = FactoryGirl.create(:admin)
		get :show, {'id'=> @admin2.id}, {'user_id'=> @admin.id}
		assert_equal @doctor2,assigns(:admin)
	end
	
	#new
	it "should not beable to call the new function " do
	 	get :new
		expect(response).to_not be_success
	end

	#create
	it "should not bable to create a new admin" do
		get :create
		expect(response).to_not be_success
	end	
end
