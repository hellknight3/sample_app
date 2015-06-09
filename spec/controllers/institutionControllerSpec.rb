require 'spec_helper'

describe InstitutionsController, type: :controller do

	before (:each) do	
	#	allow(controller).to receive(:is_director)
	#	controller.stub(:is_director).and_return(true,false)
		@director = FactoryGirl.create :admin
		@director.director = true
		@patient = FactoryGirl.create :patient
		@doctor = FactoryGirl.create :doctor
		@admin = FactoryGirl.create :admin
		end
		
	 subject {FactoryGirl.create(:institution)}
#index
	it 'show as patient' do
          controller.current_user = @patient.user
          get :index , {'id'=> subject.id}, {'user_id'=> @patient.id}
          assert_equal subject, assigns(:inst)
	end

	it 'show as doctor' do 
   	  controller.current_user = @doctor.user
 	  get :index, {'id' => subject.id}, {'user_id'=>@doctor.id}
	  assert_equal subject, assigns(:inst)	
	end	

	it 'show as admin' do
	  controller.current_user = @admin.user
	  get :index, {'id' => subject.id}, {'user_id'=>@admin.id}
	  assert_equal subject, assigns(:inst)
	end

	it 'show as director' do
	  controller.current_user = @director.user
	  get :index, {'id' => subject.id}, {'user_id' => @director.id}
	  assert_equal subject, assigns(:inst)
	end
#show	
#anyone logged should be able to view the institution
	
	it 'logged in patient' do
		controller.current_user = @patient.user
		get :show , {'id'=> subject.id}, {'user_id'=> @patient.id}
		assert_equal subject, assigns(:inst)
	end

	it 'logged in as a doctor' do
	        controller.current_user = @doctor.user
                get :show , {'id'=> subject.id}, {'user_id'=> @doctor.id}
                assert_equal subject, assigns(:inst)
	
	end

	it 'logged in as a admin' do
                controller.current_user = @admin.user
                get :show , {'id'=> subject.id}, {'user_id'=> @admin.id}
                assert_equal subject, assigns(:inst)

        end

	it 'logged in as a director' do
                controller.current_user = @director.user
                get :show , {'id'=> subject.id}, {'user_id'=> @director.id}
                assert_equal subject, assigns(:inst)

        end
#edit
#only directors can edit

	it 'edit as patient'do
		controller.stub(:is_director).and_return(false)
		controller.current_user = @patient.user
		get :edit, {'id'=> subject.id}
		expect(response).to_not be_success
		expect(flash[:notice]).to eq("You do not have permission to do that")
	end
	 it 'edit as doctor' do
		controller.stub(:is_director).and_return(false)
	  	controller.current_user = @doctor.user
                get :edit, {'id'=> subject.id}
                expect(response).to_not be_success
                expect(flash[:notice]).to eq("You do not have permission to do that")
        end

	it 'edit as admin'do 
		controller.stub(:is_director).and_return(false)
	   	controller.current_user = @admin.user
                get :edit, {'id'=> subject.id}
                expect(response).to_not be_success
                expect(flash[:notice]).to eq("You do not have permission to do that")
        end

	it 'edit as director' do
	  	controller.stub(:is_director).and_return(true)
		controller.current_user = @director.user
                get :edit, {'id'=> subject.id}, {'user_id' => @director.id}
                expect(response).to be_success
		assert_equal subject, assigns(:inst)
        end

#update
#only directors can update
	
	it 'update as patient' do
		controller.stub(:is_director).and_return(false)
		controller.current_user = @patient.user
		put :update,{'id' => subject.id, 'institution' => {:name => "Institution1", :description => "new one"}}
		 expect(response).to_not be_success
		 expect(flash[:notice]).to eq("You do not have permission to do that")
	end
	
	it 'update as doctor' do
		controller.stub(:is_director).and_return(false)
		controller.current_user = @doctor.user
		    put :update,{'id' => subject.id, 'institution' => {:name => "Institution1", :description => "new one"}}
                 expect(response).to_not be_success
                 expect(flash[:notice]).to eq("You do not have permission to do that")

	end

	it 'update as admin' do
		controller.stub(:is_director).and_return(false)
		controller.current_user = @admin.user
	        put :update,{'id' => subject.id, 'institution' => {:name => "Institution1", :description => "new one"},'user_id' => @director.user.id}
                expect(response).to_not be_success
                expect(flash[:notice]).to eq("You do not have permission to do that")

	end

	it 'update as director' do
		controller.stub(:is_director).and_return(true)
		controller.current_user = @director.user
         	    put :update,{'id' => subject.id, 'institution' => {:name => "Institution1", :description => "new one"}}
                assert_equal "Institution1", assigns(:inst).name 
		assert_equal "new one", assigns(:inst).description
		expect(response).to be_success
              
	end

end
