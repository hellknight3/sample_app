require 'spec_helper'


#RSpec.describe User do
describe PoolsController, type: :controller do
 	#test index function
	describe "index" do
		it "populates an array of users" do
			pool = create(:pool) #create new pool
			get :index #call index function
			assigns(:pool).should eq([pool]) #check pool found = pool
		end
		#check rendering
		it "renders the: index view" do 
			get :index
			response.should render_template :index
		end
	end
	
	#test show function
	describe "show" do
		it "assigns the request user to @user" do
			pool = create(:pool) #create pool
			#puts pool.name
			get :show, id: pool.id #call show function
			assigns(:pool).should eq(pool) #check pool found is the correct pool
		end
		#check rendering
		it "rends show view" do
			pool = create(:pool)
			get :show, id: pool.id
			response.should render_template :show
		end
	end

	describe "new" do
		it "assigns a new user to @user" do
			poolNew = get :new
			#puts poolNew.name
			expect(assigns(:pool)).to be_a_new(Pool)
		end
		#test rending 
		it "renders the : new template" do
			get :new
			response.should render_template :new
		end 
	end 

	#test create function
	describe "create" do
		#test using valid attributes
		context "valid attributes" do		
		it "create new contact" do
				#create new Pool expect the pool count to increase by one
				expect{post :create, pool: attributes_for(:pool)}.to change(Pool, :count).by(1)
			end
			#test redirection
			it "redirects to the home page" do
				post :create, pool: attributes_for(:pool)
				response.should redirect_to Pool.last
			end
		end
		#test invalid attributes
		#test this case when model is sorted out
=begin
		context "invalid attributes" do		
			it "create new contact" do
				#create pool with invalid attribute, check pool count does not increment
				expect{post :create, pool: attributes_for(:InvalidPool)}.to_not change(Pool, :count).by(1)
			end
			it "redirects to the home page" do
				post :create, pool: attributes_for(:pool), user: attributes_for(:InvalidPool)
				response.should render_template :new
			end
		end
=end
	end

	#test edit function
	describe "edit" do
		it "request user to @user" do
			user = create(:pool)#create new 
			puts user.nameUser
			get :edit, {'id' => "1"} #call edit function
			assigns(:pool).should eq(user)#check pool found = user
		end
		#check rendering
		it "rends show view" do
			user = create(:pool)
			get :edit, {'id' => "1"}
			response.should render_template :edit
		end
		
	end
	
	#test update function
	describe "update" do
		#test with valid attributes
		context "valid attribute" do 
			it "locate requested @user" do
				@user = create(:pool)#create new pool
				put :update, id: @user, pool: FactoryGirl.attributes_for(:pool)#check user can be updated
			end
			it "changes user attributes" do
				@user = create(:pool)#create new pool
				#save attributes
				nameUser = @user.name
				descriptionUser = @user.description
				specializationUser = @user.specialization
				institutionUser = @user.institution
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, name:"Bob", institution:"something@gmail.com", description:"barfoo",specialization:"barfoo")
				@user.reload #reload pool
				#check attributes
				@user.name.should eq(nameUser)
				@user.description.should eq(descriptionUser)
				@user.institution.should eq(institutionUser)
				@user.specialization.should eq(specializationUser)
				response.should redirect_to @user
			end
		end
		#test invalid attributes after model testing is done
=begin
		context "invalid attributes" do
			it "doesnt changes attribute" do
				@user = create(:patient)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password			
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, name:"Bob", email:"somethinggmail.com", password:"barfoo",password_confirmation:"barfoo")
				@user.reload
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)
				@user.user.name.should_not eq("Bob")
				@user.user.password.should_not eq("barfoo")
				@user.user.password_confirmation.should_not eq("barfoo")
			end
			it "doesnt changes attribute" do
				user = create(:patient)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:patient, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:"barfoo")
				@user.reload
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)
				@user.user.email.should_not eq("something@gmail.com")
				@user.user.password.should_not eq("barfoo")
				@user.user.password_confirmation.should_not eq("barfoo")
			end
			it "doesnt changes attribute" do
				user = create(:patient)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:patient, name:"Bob", email:"something@gmail.com", password:"bar",password_confirmation:"bar")
				@user.reload
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)	
				@user.user.name.should_not eq("Bob")
				@user.user.email.should_not eq("something@gmail.com")
				@user.user.password.should_not eq("bar")
				@user.user.password_confirmation.should_not eq("bar")
			end
			it "doesnt changes attribute" do
				user = create(:patient)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:patient, name:nil, email:"something@gmail.com", password:"barfo1",password_confirmation:"barfoo")
				@user.reload
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)
				@user.user.name.should_not eq("Bob")
				@user.user.email.should_not eq("something@gmail.com")
				@user.user.password.should_not eq("barfo1")
				@user.user.password_confirmation.should_not eq("barfoo")
			end
			it "doesnt changes attribute" do
				user = create(:patient)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:patient, name:nil, email:"something@gmail.com", password:nil,password_confirmation:"barfoo")
				@user.reload
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)
				@user.user.email.should_not eq("something@gmail")
				@user.user.name.should_not eq("Bob")
				@user.user.password_confirmation.should_not eq("barfoo")
			end
			it "doesnt changes attribute" do
				user = create(:patient)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:patient, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:nil)
				@user.reload
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)
				@user.user.email.should_not eq("something@gmail")
				@user.user.password.should_not eq("barfoo")
				@user.user.name.should_not eq("Bob")
			end
			it "re-renders the edit method" do
				user = create(:patient)
				put :update, id: @user, user: FactoryGirl.attributes_for(:patient, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:nil)
				response.should render_template :edit
			end
		end
	end

	describe "delete method" do
		it "deletes user" do
			@user = create(:patient)
			expect{delete :destroy, id: @user}.to change(User,:count).by(-1)
		end
		it "redirect to users" do
			@user = create(:patient)
			delete :destroy, id: @user
			response.should redirect_to user
		end
=end
		end
end