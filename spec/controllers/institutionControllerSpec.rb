require 'spec_helper'

describe InstitutionsController, type: :controller do

	before (:each) do	
	#	allow(controller).to receive(:is_director)
	#	controller.stub(:is_director).and_return(true,false)
		@director = FactoryGirl.create :userAdmin
		@director.profile.director = true
		@patient = FactoryGirl.create :userPatient
		@doctor = FactoryGirl.create :userDoctor
		@admin = FactoryGirl.create :userAdmin
		end
		
	 subject {FactoryGirl.create(:institution)}
#index
	it 'show as patient' do
          controller.current_user = @patient
          get :index , {'id'=> subject.id}, {'user_id'=> @patient.profile.id}
          assert_equal subject, assigns(:inst)
	end

	it 'show as doctor' do 
   	  controller.current_user = @doctor
 	  get :index, {'id' => subject.id}, {'user_id'=>@doctor.profile.id}
	  assert_equal subject, assigns(:inst)	
	end	

	it 'show as admin' do
	  controller.current_user = @admin
	  get :index, {'id' => subject.id}, {'user_id'=>@admin.profile.id}
	  assert_equal subject, assigns(:inst)
	end

	it 'show as director' do
	  controller.current_user = @director
	  get :index, {'id' => subject.id}, {'user_id' => @director.profile.id}
	  assert_equal subject, assigns(:inst)
	end
#show	
#anyone logged should be able to view the institution
	
	it 'logged in patient' do
		controller.current_user = @patient
		get :show , {'id'=> subject.id}, {'user_id'=> @patient.profile.id}
		assert_equal subject, assigns(:inst)
	end

	it 'logged in as a doctor' do
	        controller.current_user = @doctor
                get :show , {'id'=> subject.id}, {'user_id'=> @doctor.profile.id}
                assert_equal subject, assigns(:inst)
	
	end

	it 'logged in as a admin' do
                controller.current_user = @admin
                get :show , {'id'=> subject.id}, {'user_id'=> @admin.profile.id}
                assert_equal subject, assigns(:inst)

        end

	it 'logged in as a director' do
                controller.current_user = @director
                get :show , {'id'=> subject.id}, {'user_id'=> @director.profile.id}
                assert_equal subject, assigns(:inst)

        end
#edit
#only directors can edit

	it 'edit as patient'do
		controller.stub(:is_director).and_return(false)
		controller.current_user = @patient
		get :edit, {'id'=> subject.id}
		expect(response).to_not be_success
		expect(flash[:notice]).to eq("You do not have permission to do that")
	end
	 it 'edit as doctor' do
		controller.stub(:is_director).and_return(false)
	  	controller.current_user = @doctor
                get :edit, {'id'=> subject.id}
                expect(response).to_not be_success
                expect(flash[:notice]).to eq("You do not have permission to do that")
        end

	it 'edit as admin'do 
		controller.stub(:is_director).and_return(false)
	   	controller.current_user = @admin
                get :edit, {'id'=> subject.id}
                expect(response).to_not be_success
                expect(flash[:notice]).to eq("You do not have permission to do that")
        end

	it 'edit as director' do
	  	controller.stub(:is_director).and_return(true)
		controller.current_user = @director
                get :edit, {'id'=> subject.id}, {'user_id' => @director.profile.id}
                expect(response).to be_success
		assert_equal subject, assigns(:inst)
        end

#update
#only directors can update
	
	it 'update as patient' do
		controller.stub(:is_director).and_return(false)
		controller.current_user = @patient
		put :update,{'id' => subject.id, 'institution' => {:name => "Institution1", :description => "new one"}}
		 expect(response).to_not be_success
		 expect(flash[:notice]).to eq("You do not have permission to do that")
	end
	
	it 'update as doctor' do
		controller.stub(:is_director).and_return(false)
		controller.current_user = @doctor
		    put :update,{'id' => subject.id, 'institution' => {:name => "Institution1", :description => "new one"}}
                 expect(response).to_not be_success
                 expect(flash[:notice]).to eq("You do not have permission to do that")

	end

	it 'update as admin' do
		controller.stub(:is_director).and_return(false)
		controller.current_user = @admin
	        put :update,{'id' => subject.id, 'institution' => {:name => "Institution1", :description => "new one"},'user_id' => @director.profile.id}
                expect(response).to_not be_success
                expect(flash[:notice]).to eq("You do not have permission to do that")

	end

	it 'update as director' do
		controller.stub(:is_director).and_return(true)
		controller.current_user = @director
         	    put :update,{'id' => subject.id, 'institution' => {:name => "Institution1", :description => "new one"}}
                assert_equal "Institution1", assigns(:inst).name 
		assert_equal "new one", assigns(:inst).description      
	end

	it 'update as director, redirction' do
		 controller.stub(:is_director).and_return(true)
                 controller.current_user = @director
                 put :update,{'id' => subject.id, 'institution' => {:name => "Institution1", :description => "new one"}}
		expect(response).to redirect_to :action => :show, :id => 1
	end
end
