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
it "should not update permissions"do
      @userTest = FactoryGirl.create(:userPatient)
      admin()
      pool() 
      addPool()
      checkPoolnot()
      expect(flash[:notice]).to eq "You do not have permission to add users to this pool"
  end

  it "should not update permissions"do
    @userTest = FactoryGirl.create(:userPatient)
    doctor()
    pool
    addPool()
    success_not
    expect(response).to redirect_to root_url
end
  it "should not update permissions"do
    @userTest = FactoryGirl.create(:userPatient)
    patient()
    pool
    addPool()
    success_not
    expect(response).to redirect_to root_url
end
 
it "should add user to pool" do
  @userTest = FactoryGirl.create(:userPatient)
  director()
  pool()
  @perm = Permission.new
  @perm.user_id = @user.id
  @perm.pool_id = @pool.id
  @perm.save
  addPool()
  success_not()
  expect(response).to redirect_to root_url
end
it "should add user to pool" do
  @userTest = FactoryGirl.create(:userPatient)
  admin()
  pool()
  @perm = Permission.new
  @perm.user_id = @user.id
  @perm.pool_id = @pool.id
  @perm.save
  addPool()
  checkPool()
end

it "should add user to pool" do
  @userTest = FactoryGirl.create(:userAdmin)
  director()
  pool()
  addPool()
  checkPool()
end
it "should add user to pool" do
  @userTest = FactoryGirl.create(:userPatient)
  admin()
  pool()
  @perm = Permission.new
  @perm.user_id = @user.id
  @perm.pool_id = @pool.id
  @perm.save
  removePool()
  checkRvm()
end
  it "should not update permissions"do
    @userTest = FactoryGirl.create(:userPatient)
    doctor()
    pool
    removePool()
    success_not
    expect(response).to redirect_to root_url
end
  it "should not update permissions"do
    @userTest = FactoryGirl.create(:userPatient)
    patient()
    pool
    removePool()
    success_not
    expect(response).to redirect_to root_url
end
 
it "should add user to pool" do
  @userTest = FactoryGirl.create(:userPatient)
  director()
  pool()
  @perm = Permission.new
  @perm.user_id = @user.id
  @perm.pool_id = @pool.id
  @perm.save
  addPool()
  removePool()
  success_not
 expect(response).to redirect_to root_url
end

it "should add user to pool" do
  @userTest = FactoryGirl.create(:userAdmin)
  director()
  pool()
  addPool()
  removePool()
end

it "should index users" do
  @userTest = FactoryGirl.create(:userDoctor)
    admin()
    index()
    @number = 1
    checkIndex()
end 

it "should index users" do
  @userTest = FactoryGirl.create(:userPatient)
    admin()
    index()
    @number = 1
    checkIndex()
end
it "should index users" do
  @userTest = FactoryGirl.create(:userDoctor)
    director()
    index()
    @number = 1
    checkIndex()
end
it "should index users" do
  @userTest = FactoryGirl.create(:userAdmin)
    director()
    index()
    assigns(:users).count.should eq(2)
end
it "should index users" do
    @userTest = FactoryGirl.create(:userPatient)
    doctor()
    index()
    @number = 1
    checkIndex()
end
it "should index users" do
  @userTest = FactoryGirl.create(:userAdmin)
    doctor()
    index()
    @number = 1
    checkIndex()
end
it "should index users" do
  @userTest = FactoryGirl.create(:userDoctor)
    doctor()
    index()
    assigns(:users).count.should eq(2)
end


it "should index users" do
  @userTest = FactoryGirl.create(:userAdmin)
    admin()
    index()
    assigns(:users).count.should eq(2)
end

it "should index users" do
  @userTest = FactoryGirl.create(:userPatient)
    director()
    index()
    success_not()
end
it "shouldnt index users" do
    patient
  @userTest = FactoryGirl.create(:userDoctor)
    index()
    success_not()
end

private
def checkIndex
  assigns(:users).count.should eq(@number)
  expect(assigns(:users)).to eq([@userTest])
end
def checkRvm
 @perm= Permission.where("user_id = ? AND pool_id = ?",@user.id, @pool.id)
 @perm.empty?
end
def removePool
    get :update, 'user' => {:func => "removePool", :pool_id => @pool.id}, 'id' => @userTest.id
end
def success_not
  expect(response).to_not be_success
end
def checkPoolnot
  assert_equal nil, assigns(:perm)
end
def pool
  @pool = FactoryGirl.create(:pool)
end
def checkPool
  assert_equal @pool.id, assigns(:perm).pool_id
end
def addPool
    get :update, 'user' => {:func => "addPool", :pool_id => @pool.id}, 'id' => @userTest.id
end
def not_update()
 
  expect{update()}.to_not raise_error(ActionController::UrlGenerationError,'No route matches {:action=>"update", :controller=>"users", :id=>"1", :user=>{:name=>"Bob", :password=>"foobar", :email=>"me@gmail.com", :password_confirmation=>"foobar"}}')
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
    expect{index()}.to_not raise_error(ActionController::UrlGenerationError,'No route matches {:action=>"index", :controller=>"users", :id=>"1", :user_id=>"2"}')
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
	get :index, 'user_type' => @userTest.profile_type, 'search' => @search
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
	@user.profile.director = true
    controller.stub(:is_director?).and_return(true)
    controller.stub(:is_director).and_return(true)
end

def patient
	@user = FactoryGirl.create(:userPatient)
	controller.current_user = @user
end
end
