class PatientsController < ApplicationController
	before_action :signed_in_patient, only: [:edit, :update]
	before_action :signed_in_admin, only: [:new, :create]
	#before_action :correct_user, only: [:edit, :update]

	def show
		#shows the current users properties
		@patient = Patient.find(params[:id])
		@user = @patient.user
	end
	def new
		#creates variables for the views to initialize
		@patient = Patient.new
		@user = User.new
	end
	def create
		#this should call the create function from the user controller, i don't know if i have to do anything special to make it work though. can't get fully functional implementation until the Views are set up.
		@patient =Patient.new(patient_params)
		@user = @patient.build_user(user_params)
		if @patient.save			
			flash[:success]
			redirect_to @patient
		else
			render 'new'
		end
	end
	def edit
		@patient = Patient.find(params[:id])
		@user = @patient.user
		if(current_user.profile_type=="Admin")
			@doctors=User.find(:all, :conditions => ["profile_type = :doc",{:doc => 'Doctor'}])
		end		
	end
	def update
		#updates the patient with the provided form data
		@patient = Patient.find(params[:id])
		@user = @patient.user
		if(params[:patient][:func] == "add")
			@patient.update_attribute(:doctor_id, params[:patient][:doctor_id])
			@patient.update_attribute(:accepted, false)
			redirect_to admin_path(current_user.profile_id)
		elsif(params[:patient][:func] == "remove")
			@patient.update_attribute(:doctor_id, nil)
			@patient.update_attribute(:accepted, false)
			redirect_to admin_path(current_user.profile_id)
		else
		@patient.update(patient_params)
		@user.update(user_params)
		end
		
	end
	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
		def patient_params
		end
		#before filters
		def signed_in_patient
			unless signed_in?
				store_location
				redirect_to signin_url, notice: "Please sign in."
			end
		end
		def signed_in_admin
			if signed_in?
				if current_user.profile_type=="Admin"
				else
				redirect_to signin_url, notice: "You do not have permission to do that."
				end
			else
				store_location
				redirect_to signin_url, notice: "Please sign in."
			end
		end
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end
end
