require 'spec_helper'


#RSpec.describe User do
describe PatientsController, type: :controller do
=begin
 	#testing the index function of the controller
	describe "index" do
		it "populates an array of users" do
			person = create(:patient)#create new person variable of type patient
			puts person.user.name #prints name of person
			get :index #call index function from the controller
			assigns(:patient).should eq([person])#checks that patient found matches person
		end
		#check proper rendering occurs after index function is call
		it "renders the: index view" do 
			get :index
			response.should render_template :index
		end
	end
=end
	#test show method
	describe "show" do
		it "assigns the request user to @user" do
			user = create(:patient)#creates patient variable
			get :show, id: user.id #call show function
			assigns(:patient).should eq(user) #check patient found matches user
		end
		#check proper rending occurs after show function is called
		it "rends show view" do
			user = create(:patient)
			get :show, {'id' => "1"}
			response.should render_template :show
		end
	end

	#testing the new function
	describe "new" do
		it "assigns a new user to @user" do
			get :new #calls new function
			puts @patient.user.name
			expect(assigns(:patient)).to be_a_new(Patient) #check a new patient
		end
		#checks rendering is working after new function
		it "renders the : new template" do
			get :new
			response.should render_template :new
		end 
	end 
=begin
	#test create function
	describe "create" do
		#test valid attributes
		context "valid attributes" do		
			it "create new contact" do
				expect{post :create, patient: attributes_for(:patient), user: attributes_for(:user)}.to change(Patient, :count).by(1)#call create function to create new patient, increase patient count by one
			end
			#checks redirection after a successful create function
			it "redirects to the home page" do
				post :create, patient: attributes_for(:patient), user: attributes_for(:user)
				response.should redirect_to Patient.last
			end
		end
		#test with invalid attributes
		context "invalid attributes" do
		
			it "create new contact" do
				#try to create invalid patient check patient is not created
				expect{post :create, patient: attributes_for(:patient), user: attributes_for(:userInvalid)}.to_not change(Patient, :count).by(1)
			end
			#check redirections
			it "redirects to the home page" do
				post :create, patient: attributes_for(:patient), user: attributes_for(:userInvalid)
				response.should render_template :new
			end
		end
	end

	#test edit function
	describe "edit" do
		it "request user to @user" do
			user = create(:patient)#create new patient
			get :edit, {'id' => "1"} #call edit function 
			assigns(:patient).should eq(user)#check it has collected the proper patient
		end
		#check rendering
		it "rends show view" do
			user = create(:patient)
			get :edit, {'id' => "1"}
			response.should render_template :edit
		end
		
	end

	#test update function
	describe "update" do
		#test valid attributes
		context "valid attribute" do 
			it "locate requested @user" do
				@user = create(:patient)#create patient
				#check user has valid attributes which can be modified
				expect{put :update, id: @user, user: FactoryGirl.attributes_for(:patient)}.to  be_valid		
			end
			it "changes user attributes" do
				@user = create(:patient)#create patient
				#save attribute values to variables
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				#changes attributes values 
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, name:"Bob", email:"something@gmail.com", password:"barfoo",password_confirmation:"barfoo")
				@user.reload #reload attributes
				#check attributes have been modified
				@user.user.name.should eq("Bob")
				@user.user.email.should eq("something@gmail")
				@user.user.password.should eq("barfoo")
				@user.user.password_confirmation.should eq("barfoo")
				response.should redirect_to @user # check redirection
			end
		end
		#check invalid attributes can not be inserted
		context "invalid attributes" do
			it "doesnt changes attribute" do
				@user = create(:patient)#create new patient
				#save attributes to variables
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password			
				#try to an invalid attribute
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, name:"Bob", email:"somethinggmail.com", password:"barfoo",password_confirmation:"barfoo")
				@user.reload #reload the patient
				#check attributes have not been changed
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)
				@user.user.name.should_not eq("Bob")
				@user.user.password.should_not eq("barfoo")
				@user.user.password_confirmation.should_not eq("barfoo")
			end
			#repeat the above process with different invalid attributes
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
			#check redirection for invalid attributes#
			it "re-renders the edit method" do
				user = create(:patient)
				put :update, id: @user, user: FactoryGirl.attributes_for(:patient, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:nil)
				response.should render_template :edit
			end
		end
	end
	#check deletion method
	describe "delete method" do
		it "deletes user" do
			@user = create(:patient)#create patient
			expect{delete :destroy, id: @user}.to change(User,:count).by(-1)#check patient has been deleted
		end
		#check redirection method
		it "redirect to users" do
			@user = create(:patient)
			delete :destroy, id: @user
			response.should redirect_to user
		end
	end
=end
end