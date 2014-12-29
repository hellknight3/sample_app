require 'spec_helper'


#RSpec.describe User do
describe DoctorsController, type: :controller do
	#test index method
	describe "index" do
		it "populates an array of users" do
			person = create(:doctor)#create doctor object
			puts person.user.name #print name
			get :index#call index function
			assigns(:doctor).should eq([person])#check doctor found is equal to person
		end
		#check rendering is correct
		it "renders the: index view" do 
			get :index
			response.should render_template :index
		end
	end
	#test show function
	describe "show" do
		it "assigns the request user to @user" do
			user = create(:doctor)#create doctor object
			get :show, id: user.id#call show function
			assigns(:doctor).should eq(user)#check doctor found it equal to user
		end
		#check rendering is correct
		it "rends show view" do
			user = create(:doctor)
			get :show, {'id' => "1"}
			response.should render_template :show
		end
	end

	#test new function
	describe "new" do
		it "assigns a new user to @user" do
			get :new #call new function
			expect(assigns(:doctor)).to be_a_new(Doctor)#check new object created is a new doctor
		end
		#check rendering is correct
		it "renders the : new template" do
			get :new
			response.should render_template :new
		end 
	end 
	
	#test create function
	describe "create" do
		#test with valid attributes
		context "valid attributes" do		
			it "create new contact" do
				#create a new doctor with the correct attributes, check number of doctors has increased by 1
				expect{post :create, doctor: attributes_for(:doctor), user: attributes_for(:user)}.to change(Doctor, :count).by(1)
			end
			#check redirection
			it "redirects to the home page" do
				post :create, doctor: attributes_for(:doctor), user: attributes_for(:user)
				response.should redirect_to Doctor.last
			end
		end
		#test create function with invalid attributes
		context "invalid attributes" do
			it "create new contact" do
			#create a doctor with invalid attributes, check doctor count does not increment
				expect{post :create, doctor: attributes_for(:doctor), user: attributes_for(:userInvalid)}.to_not change(Doctor, :count).by(1)
			end
			#check redirection
			it "redirects to the home page" do
				post :create, doctor: attributes_for(:doctor), user: attributes_for(:userInvalid)
				response.should render_template :new
			end
		end
	end

	#check edit function
	describe "edit" do
		it "request user to @user" do
			user = create(:doctor)#create new doctor
			get :edit, {'id' => "1"} #call get function
			assigns(:doctor).should eq(user)#check doctor found is equal to user
		end
		#check rendering
		it "rends show view" do
			user = create(:doctor)
			get :edit, {'id' => "1"}
			response.should render_template :edit
		end		
	end

	#test update function
	describe "update" do
		#check function with valid attributes
		context "valid attribute" do 
			it "locate requested @user" do
				@user = create(:doctor)#create new doctor
				put :update, id: @user, user: FactoryGirl.attributes_for(:doctor)# check user can be updated
			end
			it "changes user attributes" do
				@user = create(:doctor)#create new doctor
				#save all attributes 
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				#update user
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, name:"Bob", email:"something@gmail.com", password:"barfoo",password_confirmation:"barfoo")
				@user.reload#reload the user
				#check attributes have been changed
				@user.user.name.should eq("Bob")
				@user.user.email.should eq("something@gmail")
				@user.user.password.should eq("barfoo")
				@user.user.password_confirmation.should eq("barfoo")
				response.should redirect_to @user#check redirection
			end
		end
		#check update does not complete with invalid attributes
		context "invalid attributes" do
			it "doesnt changes attribute" do
				@user = create(:doctor)	#create new doctors
				#save attributes
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				#update doctor using invalid attributes
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, name:"Bob", email:"somethinggmail.com", password:"barfoo",password_confirmation:"barfoo")
				@user.reload #reload the doctor
				#check attributes have not changed
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)
				@user.user.name.should_not eq("Bob")
				@user.user.password.should_not eq("barfoo")
				@user.user.password_confirmation.should_not eq("barfoo")
			end
			#the following check for different invalid attributes, same process as above
			it "doesnt changes attribute" do
				user = create(:doctor)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:doctor, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:"barfoo")
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
				user = create(:doctor)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:doctor, name:"Bob", email:"something@gmail.com", password:"bar",password_confirmation:"bar")
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
				user = create(:doctor)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:doctor, name:nil, email:"something@gmail.com", password:"barfo1",password_confirmation:"barfoo")
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
				user = create(:doctor)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:doctor, name:nil, email:"something@gmail.com", password:nil,password_confirmation:"barfoo")
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
				user = create(:doctor)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:doctor, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:nil)
				@user.reload
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)
				@user.user.email.should_not eq("something@gmail")
				@user.user.password.should_not eq("barfoo")
				@user.user.name.should_not eq("Bob")
			end
			#recheck rendering for invalid attributes
			it "re-renders the edit method" do
				user = create(:doctor)
				put :update, id: @user, user: FactoryGirl.attributes_for(:doctor, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:nil)
				response.should render_template :edit
			end
		end
	end
	
	#test delete method
	describe "delete method" do
		it "deletes user" do
			@user = create(:doctor)#create doctor
			#try to delete doctor, check number of doctors decreased by one
			expect{delete :destroy, id: @user}.to change(User,:count).by(-1)
		end
		#check rendering
		it "redirect to users" do
			@user = create(:doctor)
			delete :destroy, id: @user
			response.should redirect_to user
		end
	end

end