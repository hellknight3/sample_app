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
	it "should find the admins profile" do
	#	puts @admin.id
		get :index, {'id' =>@admin.id}, {'user_id' => @admin.id}
		#check admin foundis the proper admin
		expect(response).to be_success
	#	puts @admin.id
#		puts assigns(:admin).user.id
#		assert_equal @admin.user.id, assigns(:admin).user.id
	end
 
	#show
	it "should view their profile" do
		get :index, {'id'=> @admin.id}, {'user_id'=> @admin.id}
		#check if admin is shown and is the proper admin	
	#	assert_equal @admin, assigns(:admin)
		expect(response).to be_success
	end
	
	it "should be able to view other admins profiles" do
		@admin2 = FactoryGirl.create(:admin)
		get :show, {'id'=> @admin2.id}, {'user_id'=> @admin.id}
	#	assert_equal @admin2,assigns(:admin)
		expect(response).to be_success
	end
	
	#new
	it "should not be able to call the new function " do
	 	get :new
		expect(response).to_not be_success
	end

	#create
	it "should not be able to create a new admin" do
		@admin.director=false
		get :create
		expect(response).to_not be_success
	end
	it "should be able to create an admin if is a director"
		@admin.director=true
		get :create
		expect(response).to be_success
	end
	#update

        it "update the admins attributes" do
                put :update, { 'id' =>@admin.id, 'user'=>{ :name=>"Bob", :email=>"something@gmail.com", :password=>"barfoo",:password_confirmation=>"barfoo",:old_password=>"foobar"}}
        assert_equal "Bob", assigns(:admin).user.name
        assert_equal "something@gmail.com", assigns(:admin).user.email
        assert_equal "barfoo", assigns(:admin).user.password
        end

        it "should only update the name" do
                put :update,{ 'id' =>@admin.id, 'user'=>{ :name=>"Bob", :email=>@admin.user.email, :password=>@admin.user.password,:password_confirmation=>@admin.user.password,:old_password=>@admin.user.password}}
                assert_equal "Bob", assigns(:admin).user.name
        end

        it "should only update the pw" do
                put :update, { 'id' =>@admin.id, 'user'=>{ :name=>@admin.user.name, :email=>@admin.user.email, :password=>"barfoo",:password_confirmation=>"barfoo",:old_password=>@admin.user.password}}
                assert_equal "barfoo", assigns(:admin).user.password
        end

        it"shouldnt update the email" do
                put :update, { 'id' =>@admin.id, 'user'=>{ :name=>@admin.user.name, :email=>"somethinggmail.com", :password=>@admin.user.password,:password_confirmation=>@admin.user.password,:old_password=>@admin.user.password}}
                assert_not_equal "somethinggmail.com", assigns(:admin).user.email
        end

 it "shouldnt update the pw"do
                  put :update, { 'id' =>@admin.id, 'user'=>{ :name=>@admin.user.name, :email=>@admin.user.email, :password=>"barfoo",:password_confirmation=>"barf0oo",:old_password=>@admin.user.password}}
                assert_not_equal "barfoo", assigns(:admin).user.password
                assert_not_equal "barf0oo", assigns(:admin).user.password_confirmation
        end

        it "should not update the admins attributes" do
                put :update, { 'id' =>@admin.id, 'user'=>{ :name=>"Bob", :email=>"something@gmail.com", :password=>"barfoo",:password_confirmation=>"barfoo",:old_password=>"wrong"}}
        assert_not_equal "Bob", assigns(:admin).user.name
        assert_not_equal "something@gmail.com", assigns(:admin).user.email
        assert_not_equal "barfoo", assigns(:admin).user.password
        end
 it "shouldnot update the pw(to sort)" do
                put :update, { 'id' =>@admin.id, 'user'=>{ :name=>@admin.user.name, :email=>@admin.user.email, :password=>"foo",:password_confirmation=>"foo",:old_password=>@admin.user.password}}
                expect(response).to_not be_success

                assert_equal "foo", assigns(:admin).user.password

      end

end
