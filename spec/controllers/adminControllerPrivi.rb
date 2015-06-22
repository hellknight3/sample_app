require 'spec_helper'

describe AdminsController, type: :controller do
	before(:each) do
		@admin = FactoryGirl.create(:admin)
	end
	it "show_admin as doctor" do
		sign_in_doctor()
		show_action()
		check_not()
	end	

	it "show_admin as doctor render" do 
		sign_in_doctor()
		show_action()
		check_not_success()
	end

	it"show_admin as director"	do
		sign_in_director()
		show_action()
#		check()
	end
	
	it"show_admin as director success" do
		sign_in_director()
		show_action()
		check_success()
	end

	it "show_admin as patient" do
		sign_in_patient()
		show_action()
		check_not()
	end

	it"show_admin as patient not success" do
		sign_in_patient()
		show_action()
		check_not_success()
	end
	
 	it "show_admin as patient render" do
		sign_in_patient()
		show_action()
		expect(response).to redirect_to root_url
	end
	
	it "index_admin as doctor" do
		sign_in_doctor()
		index_action()
		check_not()
	end
	
	it "index_admin as doctor success" do
		sign_in_doctor()
		index_action()
		check_not_success()	
	end

	it "index_admin as director" do
		sign_in_director()
		index_action()
		check_success()
	end
	it "index_admin as director succes" do
		sign_in_director()
		index_action()
		check_success()
	end	
	it "index_admin as patient" do
                sign_in_patient()
                index_action()
                check_not()
        end

        it "index_admin as patient success" do
                sign_in_patient()
                index_action()
                check_not_success()
        end

	it"index_admin as admin, search admins" do
		sign_in_admin()
		@admin2 = FactoryGirl.create(:admin)
		get  :index, 'id' => @admin.id, 'user_id' => @user.id, 'user_type' => Admin, 'search' => @admin2.user.name
		assigns(:admins).count.should eq(1)
		  expect(assigns(:admins)).to eq([@admin2.user])
	end
	it"index_admin as admin, search doctor" do
		sign_in_admin()
		@doctor = FactoryGirl.create(:doctor)
		get  :index, 'id' => @admin.id, 'user_id' => @user.id, 'user_type' => Doctor, 'search' => @doctor.user.name
		assigns(:admins).count.should eq(1)
		  expect(assigns(:admins)).to eq([@doctor.user])
	end

	it"index_admin as admin, search doctor" do
		sign_in_admin()
		@patient = FactoryGirl.create(:patient)
		get  :index, 'id' => @admin.id, 'user_id' => @user.id, 'user_type' => Patient, 'search' => @patient.user.name
		assigns(:admins).count.should eq(1)
		  expect(assigns(:admins)).to eq([@patient.user])
	end
	
	it"index_admin as director,  search admins" do
		sign_in_director()
		@admin2 = FactoryGirl.create(:admin)
		get  :index, 'id' => @admin.id, 'user_id' => @user.id, 'user_type' => Admin, 'search' => @admin2.user.name
		assigns(:admins).count.should eq(1)
		  expect(assigns(:admins)).to eq([@admin2.user])
	end
	it"index_admin as director, no search doctor" do
		sign_in_director()
		@doctor = FactoryGirl.create(:doctor)
		get  :index, 'id' => @admin.id, 'user_id' => @user.id, 'user_type' => Doctor, 'search' => @doctor.user.name
		assigns(:admins).count.should eq(1)
		  expect(assigns(:admins)).to eq([@doctor.user])
	end

	it"index_admin as director, search patient" do
		sign_in_director()
		@patient = FactoryGirl.create(:patient)
		get  :index, 'id' => @admin.id, 'user_id' => @user.id, 'user_type' => Patient, 'search' => @patient.user.name
		expect(assigns(:admins)).to eq([@patient.user])
		expect(response).to render_template 'index'
	end
	
	it "new_admin as doctor" do
                sign_in_doctor()
                new_action()
                check_not()
        end

        it "new_admin as doctor  success" do
                sign_in_doctor()
                new_action()
                check_not_success()
        end
	
	it "new_admin as doctor render" do
		sign_in_doctor()
		new_action()
		expect(response).to redirect_to signin_url
	end

	it "new_admin as doctor flash" do
		sign_in_doctor()
		new_action()
		expect(flash[:notice]).to eq("You do not have permission to do that.")
	end

	it "new_admin as director" do
		sign_in_director()
		new_action()
		expect(assigns(:admin)).to be_a_new(Admin)
	end
		
	it "new_admin as director success" do
		sign_in_director()
                new_action()
		check_success()
	end	
	it "new_admin as patient" do
                sign_in_patient()
                new_action()
                check_not()
        end

        it "new_admin as patient  success" do
                sign_in_patient()
                new_action()
                check_not_success()
        end

        it "new_admin as patient render" do
                sign_in_patient()
                new_action()
                expect(response).to redirect_to signin_url
        end

        it "new_admin as patient flash" do
                sign_in_patient()
                new_action()
                expect(flash[:notice]).to eq("You do not have permission to do that.")

	end

	 it "create_admin as doctor" do
                sign_in_doctor()
                expect{create_action()}.to_not change(Admin,:count)
        end
	it "create_admin as director" do
                sign_in_director()
                expect{create_action()}.to change(Admin,:count)
        end
	it "create_admin as director" do
		 sign_in_director()
		create_action()
		should redirect_to :action => :edit, :id => 3
	end

        it "create_admin as doctor  success" do
                sign_in_doctor()
                create_action()
                check_not_success()

        end
	it "create_admin as doctor render" do
                sign_in_doctor()
                create_action()
                expect(response).to redirect_to signin_url
        end

        it "create_admin as doctor flash" do
                sign_in_doctor()
                create_action()
                expect(flash[:notice]).to eq("You do not have permission to do that.")
        end


        it "create_admin as patient" do
                sign_in_patient()
                expect{create_action()}.to_not change(Admin,:count)
        end

        it "create_admin as patient  success" do
                sign_in_patient()
                create_action()
                check_not_success()
        end

        it "creat_admin as patient render" do
                sign_in_patient()
                create_action()
                expect(response).to redirect_to signin_url
        end

        it "create_admin as patient flash" do
                sign_in_patient()
                create_action()
                expect(flash[:notice]).to eq("You do not have permission to do that.")

        end

	it "update_admin as doctor" do
                sign_in_doctor()
                update_action()
                check_not()
        end

        it "update_admin as doctor render" do
                sign_in_doctor()
                update_action()
                check_not_success()
        end
	
	it  "update_admin as director " do
		sign_in_director()
		create_pool()
		get :update, 'admin' => {:func => "addPool", :pool_id => @pool.id}, user: attributes_for(:user), 'id'=> @admin.id
		expect(flash[:notice]).to eq "permissions updated"	
		assert_equal @pool.id, assigns(:perm).pool_id
	end

	it "update_Admin_fail as director" do
		sign_in_director()
		get:update, 'admin' =>{:func =>"addPool", :pool_id => 2}, user: attributes_for(:user), 'id' => @admin.id
		expect(flash[:alert]).to eq "a problem occurred updating the users permissions"
		expect(response).to redirect_to :action => 'edit', :user_id => @admin.id
	end
	
        it "update_admin as patient" do
                sign_in_patient()
                update_action()
                check_not()
        end

        it"update_admin as patient not success" do
                sign_in_patient()
                update_action()
                check_not_success()
        end

private
	def sign_in_admin
		@user = FactoryGirl.create(:admin)
		controller.current_user = @user.user
	end
	def update_action
		get :update, admin: attributes_for(:admin), user: attributes_for(:user), 'id'=> @admin.id
	end
	def create_action
		get :create,  doctor: attributes_for(:doctor), user: attributes_for(:user)
	end

	def new_action
		get :new
	end
	def sign_in_doctor
		@user = FactoryGirl.create(:doctor)
		controller.current_user = @user.user
	end
	
	def sign_in_patient 
		@user= FactoryGirl.create(:patient)
		controller.current_user = @user.user
	end
	
	def sign_in_director
		@user = FactoryGirl.create(:admin)	
		@user.director = true
		controller.current_user = @user.user
		controller.stub(:is_director).and_return(true)
		controller.stub(:is_admin).and_return(true)
	end

	def show_action
		get :show, 'id' => @admin.id, 'user_id' => @user.id
		if @user.user.profile_type == "Admin"
			assert_equal @admin, assigns(:admin)
		else
			assert_not_equal @admin, assigns(:admin)
		end

	end
	
	def check_not 
		assert_not_equal @admin, assigns(:admin)
	end

	def check
		assert_equal @admin, assigns(:admin)
	end
	
	def check_false
		assert_not_equal @admin, assigns(:admin)
	end
	
	def check_success
		expect(response).to be_success
	end
	
	def check_not_success
		expect(response).to_not be_success
	end
	
	def index_action
		get :index, 'id' => @admin.id, 'user_id' => @user.id
	end
	
	def create_pool
		@pool = FactoryGirl.create(:pool)
	end
end
