require 'spec_helper'
#being reworked to test that user cannot be created by itself

#RSpec.describe User do
describe UsersController, type: :controller  do

	it "should not create user without profile" do
		expect{FactoryGirl.create(:user)}.to raise_error(ActiveRecord::RecordInvalid,"Validation failed: Profile can't be blank")
	end

	it "should be able to show user" do
		@userTest = FactoryGirl.create(:userPatient)
		admin()
		not_show()
	end
	it "should be able to show user" do
		@userTest = FactoryGirl.create(:userPatient)
		doctor()
		not_show()
	end
	it "should be able to show user" do
		@userTest = FactoryGirl.create(:userPatient)
		patient()
	  not_show()
    end


    it "should be able to index user" do                                                                                                         
          @userTest = FactoryGirl.create(:userPatient)
          admin()
          not_index()
    end
    it "should be able to index user" do
             @userTest = FactoryGirl.create(:userPatient)
             doctor()
               not_index()
        end 
        it "should be able to index user" do
            @userTest = FactoryGirl.create(:userPatient)
            patient()
            not_index()
        end

	it "should be able to new user" do
		@userTest = FactoryGirl.create(:userPatient)
		admin()
		not_new()
	end
	it "should be able to new user" do
		@userTest = FactoryGirl.create(:userPatient)
		doctor()
		not_new()
	end
	it "should be able to new user" do
		@userTest = FactoryGirl.create(:userPatient)
		patient()
	  not_new()
    end


	it "should be able to create user" do
		@userTest = FactoryGirl.create(:userPatient)
		admin()
		not_create()
	end
	it "should be able to create user" do
		@userTest = FactoryGirl.create(:userPatient)
		doctor()
		not_create()
	end
	it "should be able to create user" do
		@userTest = FactoryGirl.create(:userPatient)
		patient()
	  not_create()
    end

	it "should be able to edit user" do
		@userTest = FactoryGirl.create(:userPatient)
		admin()
		not_edit()
	end
	it "should be able to edit user" do
		@userTest = FactoryGirl.create(:userPatient)
		doctor()
		not_edit()
	end
	it "should be able to edit user" do
		@userTest = FactoryGirl.create(:userPatient)
		patient()
	  not_edit()
    end

  it "should be able to update user" do
		@userTest = FactoryGirl.create(:userPatient)
		admin()
		not_update()
	end
	it "should be able to update user" do
		@userTest = FactoryGirl.create(:userPatient)
		doctor()
		not_update()
	end
	it "should be able to update user" do
		@userTest = FactoryGirl.create(:userPatient)
		patient()
	  not_update()
    end




private
def not_update()
 
  expect{update()}.to raise_error(ActionController::UrlGenerationError,'No route matches {:action=>"update", :controller=>"users", :id=>"1", :user=>{:name=>"Bob", :password=>"foobar", :email=>"me@gmail.com", :password_confirmation=>"foobar"}}')
end
def update
  get :update, 'user' => {:name =>"Bob", :password=>"foobar", :email=>"me@gmail.com", :password_confirmation=>"foobar"}, 'id' => @userTest.id
end
def not_edit
   expect{get :edit, 'id' => @userTest.id}.to raise_error(ActionController::UrlGenerationError,'No route matches {:action=>"edit", :controller=>"users", :id=>"1"}')
end

def not_create
  expect{get :create}.to raise_error(ActionController::UrlGenerationError,'No route matches {:action=>"create", :controller=>"users"}')
end
def not_new
  expect{get :new}.to raise_error(ActionController::UrlGenerationError,'No route matches {:action=>"new", :controller=>"users"}')
end
def not_index
    expect{index()}.to raise_error(ActionController::UrlGenerationError,'No route matches {:action=>"index", :controller=>"users", :id=>"1", :user_id=>"2"}')
end

def not_show
    expect{show()}.to raise_error(ActionController::UrlGenerationError,'No route matches {:action=>"show", :controller=>"users", :id=>"1"}')
end
def show
	get :show, 'id' => @userTest.profile.id
end
def check 
	assert_equal @userTest, assigns(:user)
end
def check_not
	assert_not_equal @userTest, assigns(:user)
end
def index
	get :index, 'id' => @userTest.id, 'user_id' => @user.id
end

def admin
	@user = FactoryGirl.create(:userAdmin)
	controller.current_user = @user
end

def doctor
	@user = FactoryGirl.create(:userDoctor)
	controller.current_user = @user
end

def director
	admin()
	@admin.profile.director = true
end

def patient
	@user = FactoryGirl.create(:userPatient)
	controller.current_user = @user
end
end
