require 'spec_helper'

describe DoctorsController, type: :controller do
	before(:each) do
		@doctor = FactoryGirl.create(:doctor)
	end

	it "show_doctor as admin" do
		admin()
		show_action()
		check()
	end
	 
	it "show_doctor as director" do
		director()
		show_action()
		check()
	end
	
	it "show as a patient" do
		patient()
		show_action()
		check_not()
	end

        it "show_doctor as admin render" do
		admin()
		show_action()
		should render_template(:show)
        end

        it "show_doctor as director render" do
        	director()
		show_action()
		should render_template(:show)

	end

        it "show as a patient render" do
		patient()
		show_action()
		should_not render_template(:show)
		expect(flash[:alert]).to eq "You do not have permission do view this doctor."
	end
	it "index_doctor as admin" do
                admin()
                index_action()
                check()
        end

        it "index_doctor as director" do
                director()
                index_action()
                check_not()
        end

        it "index as a patient" do
                patient()
                index_action()
                check_not()
        end

        it "index_doctor as admin render" do
                admin()
                index_action()
                expect(response).to be_success
		should render_template(:index)
        end

        it "index_doctor as director render" do
                director()
                index_action()
                should_not render_template(:index)
		expect(flash[:alert]).to eq "You do not have permission do view this doctors patients."
        end

        it "index_doctor patient render" do
                patient()
                index_action()
               should_not render_template(:index)
		expect(flash[:alert]).to eq "You do not have permission do view this doctors patients."
        end
	it "create_doctor as admin" do
                admin()
                expect{create_action()}.to change(Doctor,:count)
        end

        it "create_doctor as director" do
                director()
                expect{create_action()}.to change(Doctor,:count).by(1)
        end

        it "create_doctor as a patient" do
                patient()
                create_action()
                expect{create_action()}.to_not change(Doctor,:count)
        end
	 it "create_doctor as admin render" do
                admin()
		create_action()
		expect(flash[:notice]).to eq "Doctor save successfully."
		expect(response).to redirect_to :action=> :edit, :id =>2
      end

        it "create_doctor as director render" do
                director()
		create_action()
		 expect(flash[:notice]).to eq"Doctor save successfully."
		expect(response).to redirect_to :action => :edit, :id =>2
       end

        it "create_doctor as a patient render" do
                patient()
                create_action()
		expect(flash[:notice]).to eq "You do not have permission to do that."
		expect(response).to redirect_to signin_url
        end

	it "new_doctor as admin" do
		admin()
		new_action()
		expect(assigns(:doctor)).to be_a_new(Doctor)
	end 

	it "new_doctor as director" do
            director()
	    new_action()
		expect(assigns(:doctor)).to be_a_new(Doctor)
        end
	 it "new_doctor as patient" do
        	patient()
	        new_action()
		expect(response).to_not be_success
        end
	 it "new_doctor as admin render" do
               admin()
		 new_action()
		should render_template(:new)
        end
	it "new_doctor as  director render" do
                director()
		new_action()
		should render_template(:new)
        end
	it "new_doctor as patient  render" do
        	patient()
	        new_action()
		expect(flash[:notice]).to eq "You do not have permission to do that."
                expect(response).to redirect_to signin_url
        end

	it "update_doctor as admin" do
		admin()
		update_action()
	end
 	it "update_doctor as dirctor" do
               	 director()
		 update_action()
        end
	 it "update_doctor as patient" do
                patient()
		update_action()
		expect(response).to_not be_success
        	expect(flash[:alert]).to eq "You do not have permission to edit this doctor"
                expect(response).to redirect_to root_url
	end

	it "edit_doctor as admin" do
		admin()
		edit_action()
		check()
	end
	it "edit_doctor as director " do
		director()
		edit_action()
		check()
        end
	it "edit_doctor as patient " do
		patient()
		edit_action()
		check_not()
        end

	it "edit_doctor as admin render" do
		admin()
		edit_action()
		should render_template(:edit)
	end
	
	it "edit_doctor as director render" do
		director()
		edit_action()
		should render_template(:edit)
	end
	it "edit_doctor as patient" do
		patient()
		edit_action()
		expect(flash[:alert]).to eq "You do not have permission to edit this doctor"
		expect(response).to redirect_to root_url
	end
private
	def edit_action
		get :edit, 'id' => @doctor.id
	end
	def update_action
		get :update, 'doctor' => {:func => "addPool"}, user: attributes_for(:user), 'id' => @doctor.id
	end 
	def new_action
		get :new
	end
	def create_action
		get :create, doctor: attributes_for(:doctor), user: attributes_for(:user)  
	end
	def check
		assert_equal @doctor, assigns(:doctor)
	end

	def check_not()
		assert_not_equal @doctor, assigns(:doctor)
	end
	def show_action 
		get :show, {'id' => @doctor.id}, {'user_id'=> @user.id}
	end
	def patient
		@user = FactoryGirl.create(:patient)
		controller.current_user = @user.user
	end
	def admin
		@user = FactoryGirl.create(:admin)
		controller.current_user = @user.user
	end
	def director 
		@user = FactoryGirl.create(:admin)
		@user.director = true
		controller.current_user = @user.user
		controller.stub(:is_director).and_return(true)
	end
	def index_action
		get :index, {'id' => @doctor.id}
	end
end
