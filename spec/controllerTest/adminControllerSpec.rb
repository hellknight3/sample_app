require 'spec_helper'


#testing the AdminsController, type must be specified
describe AdminsController, type: :controller do
	#testing the index function of the controller
	describe "index" do
		it "populates an array of users" do
			person = create(:admin)#creates a person variable which is an admin
			puts person.user.name#prints out persons name to the cmd prompt 
			puts person.id
			get :index #gets the index method from the controller
			assigns(:admin).should eq([person])#checks that the results from the get method is equal to the person variable
		end
		#get the index method and checks that the appropriate template is rendered
		it "renders the: index view" do 
			get :index
			response.should render_template :index
		end
	end
=begin
	#testing the show function
	describe "show" do
		it "assigns the request user to @user" do
			user = create(:admin) #creates admin
			get :show, id: user.id 	#call the show method, providing it with the user's id
			assigns(:admin).should eq(user)#checks the admin found matches should equal the user variable
		end
		#get the show method and checks that the appropriate template is rendered
		it "rends show view" do
			user = create(:admin)
			get :show, {'id' => "1"}
			response.should render_template :show
		end
	end
 
	#testing the new function
	describe "new" do
		it "assigns a new user to @user" do
			get :new	#calls the new method
			expect(assigns(:admin)).to be_a_new(Admin)#checks that the new admin the admin array is a new admin
		end
		#get the new method and checks that the appropriate template is rendered
		it "renders the : new template" do
			get :new
			response.should render_template :new
		end 
	end 

	#testing the create function
	describe "create" do
		#testing valid attributes
		context "valid attributes" do
			it "create new contact" do
				expect{post :create, admin: attributes_for(:admin), user: attributes_for(:user)}.to change(Admin, :count).by(1)#call the create method in the controller and create a new admin, check that the admin count increases by 1
			end
			#get the create method and checks that the appropriate template is rendered
			it "redirects to the home page" do
				post :create, admin: attributes_for(:admin), user: attributes_for(:user)
				response.should redirect_to Admin.last
			end
		end
		#testing inValid inputs
		context "invalid attributes" do
		
			it "create new contact" do
				expect{post :create, admin: attributes_for(:admin), user: attributes_for(:userInvalid)}.to_not change(Admin, :count).by(1)#call the create method in the controller with invalid attributes, expect count not the change
			end
			#checks that the page redirect correctly
			it "redirects to the home page" do
				post :create, admin: attributes_for(:admin), user: attributes_for(:userInvalid)
				response.should render_template :new
			end
		end
	end

	#testing the edit function
	describe "edit" do
		it "request user to @user" do
			user = create(:admin)#create new admin
			get :edit, {'id' => "1"}#call the edit method	
			assigns(:admin).should eq(user)# check that the user which was found to be edited is the correct user
		end
		#checks that the page redirect correctly
		it "rends show view" do
			user = create(:admin)
			get :edit, {'id' => "1"}
			response.should render_template :edit
		end
		
	end

	#testing the update function
	describe "update" do
		#testing valid attributes
		context "valid attribute" do 
			it "locate requested @user" do
				@user = create(:admin)#create new admin
				expect{put :update, id: @user, user: FactoryGirl.attributes_for(:admin)}.to be_valid #puts the user.id and the attributes for the user into the update method, this should be valid
			end
			it "changes user attributes" do
				@user = create(:admin)#creat new admin
				#save admin name, email and pw as local variables
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				#put in the user id, attributes and new attributes to the update method
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, name:"Bob", email:"something@gmail.com", password:"barfoo",password_confirmation:"barfoo")
				@user.reload #reloads the user
				#checks attribute have changed
				@user.user.name.should eq("Bob")
				@user.user.email.should eq("something@gmail")
				@user.user.password.should eq("barfoo")
				@user.user.password_confirmation.should eq("barfoo")
				response.should redirect_to @user #check redirect 
			end
		end
		context "invalid attributes" do
			it "doesnt changes attribute" do
				@user = create(:admin)	#create new admin 
				#save admin name, email and pw as local variables
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password	
				#put in the user id, attributes and new attributes to the update method				
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, name:"Bob", email:"somethinggmail.com", password:"barfoo",password_confirmation:"barfoo")
				@user.reload #reload user
				#checks that attributes have not changed
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)
				@user.user.name.should_not eq("Bob")
				@user.user.password.should_not eq("barfoo")
				@user.user.password_confirmation.should_not eq("barfoo")
			end
			#invalid attributes of different forms are tested its the same process as above
			it "doesnt changes attribute" do
				user = create(:admin)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:admin, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:"barfoo")
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
				user = create(:admin)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:admin, name:"Bob", email:"something@gmail.com", password:"bar",password_confirmation:"bar")
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
				user = create(:admin)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:admin, name:nil, email:"something@gmail.com", password:"barfo1",password_confirmation:"barfoo")
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
				user = create(:admin)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:admin, name:nil, email:"something@gmail.com", password:nil,password_confirmation:"barfoo")
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
				user = create(:admin)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:admin, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:nil)
				@user.reload
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)
				@user.user.email.should_not eq("something@gmail")
				@user.user.password.should_not eq("barfoo")
				@user.user.name.should_not eq("Bob")
			end
			#check the redirection of the method
			it "re-renders the edit method" do
				user = create(:admin)
				put :update, id: @user, user: FactoryGirl.attributes_for(:admin, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:nil)
				response.should render_template :edit
			end
			#check failure redirection - need to test this
			it "doesnt changes attribute" do
				user = create(:admin)
				put :update, id: @user, user: FactoryGirl.attributes_for(:admin, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:nil)
				response.should render_template :edit
			end
		end
	end
	
	#test delete method
	describe "delete method" do
		it "deletes user" do
			@user = create(:admin)#create new admin
			expect{delete :destroy, id: @user}.to change(User,:count).by(-1) #delete admin, expect count to decrease by 1
		end
		#check the redirection 
		it "redirect to users" do
			@user = create(:admin)
			delete :destroy, id: @user
			response.should redirect_to user
		end
	end
=end
end