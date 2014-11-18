require 'spec_helper'


#RSpec.describe User do
describe UsersController, type: :controller do
	describe "index" do
		it "populates an array of users" do
			user = create(:user)
		#	user = User.create
			get:index
			assigns(:users).should eq([user])
		end
		it "renders the: index view" do 
			get :index
			response.should render_template :index
		end
	end

	describe "show" do
		it "assigns the request user to @user" do
			user = create(:user)
			get :show, {'id' => "1"}
			assigns(:user).should eq(user)
		end
		it "rends show view" do
			user = create(:user)
			get :show, {'id' => "1"}
			response.should render_template :show
		end
	end

	describe "new" do
		it "assigns a new user to @user" do
		#	get :new
		#	assigns(:user).should be_valid
		end
		it "renders the : new template" do
			get :new
			response.should render_template :new
		end 
	end 

	describe "create" do
		context "valid attributes" do
		
			it "create new contact" do
				expect{post :create, user: {name: "Joe", email: "me@gmail.com", password: "foobar", password_confirmation: "foobar"}}.to change(User, :count).by(1)
			end
			it "redirects to the home page" do
				post :create, user: {name: "Joe", email: "me@gmail.com", password: "foobar", password_confirmation: "foobar"}
				response.should redirect_to User.last
			end
		end
		context "invalid attributes" do
		
			it "create new contact" do
				expect{post :create, user: {name: "Joe", email: "megmail.com", password: "foobar", password_confirmation: "foobar"}}.to_not change(User, :count).by(1)
			end
			it "redirects to the home page" do
				post :create, user: {name: "Joe", email: "megmail.com", password: "foobar", password_confirmation: "foobar"}
				response.should render_template :new
			end
		end
	end

#describe "edit" do check show
#end

	describe "update" do
	before :each do
#		@user = FactoryGirl(:user, name: "Joe", email: "me@gmail.com", password: "foobar", password_confirmation: "foobar")
	end
		context "valid attribute" do 
#			user = FactoryGirl(:user, name: "Joe", email: "me@gmail.com", password: "foobar", password_confirmation: "foobar")
			it "locate requested @user" do
				@user = create(:user, name: "Joe", email: "me@gmail.com", password: "foobar", password_confirmation: "foobar")
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, name: "Joe", email: "me@gmail.com", password: "foobar", password_confirmation: "foobar")
			end
		end
	end


end