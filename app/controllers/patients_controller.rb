class PatientsController < ApplicationController
	helper UsersHelper
	#performs a before action, in other words it will run the script defined at the start method-> :signed_in_admin
	#this will then run before every POST action that exists after -> :new, :create, :edit, :update
	before_action :signed_in, only: [:edit, :update]
	before_action :signed_in_admin, only: [:new, :create]
	before_action :correct_user, only: [:show,:edit, :update]
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
		#creates the patient based on the allowed patient parameters
		@patient =Patient.new(patient_params)
		#creates a user and attaches it to the patient with the user parameter restrictions required
		#since the association exists between user and patient, build_user handles the whole process, but acts like a new command
		@user = @patient.build_user(user_params)
		#tries to save the patient to the database
		if @patient.save
			#flashes a success message for the admin		
			flash[:notice] ="successfully added patient"
			#redirects to the pool index page
			redirect_to edit_doctor_path(@patient)
		else
			#reloads the new page so that the forms can have the correct information
			render 'new'
		end
	end
	def edit
		#finds the user that is defined in the param hash and finds that user
		@patient = Patient.find(params[:id])
		#finds the user profile of the patient that is found
		@user = @patient.user
		if(is_admin)
			#if the current user is an admin it will create a doctor variable finding all the user profiles with a profile_type of doctor in the database
			#@doctors=User.find(:all, :conditions => ["profile_type = :doc",{:doc => 'Doctor'}])
			#@availableDocs= @doctors.pools.users.where("profile_type: = ?","Doctor").uniq.all
			@doctors= User.joins('LEFT OUTER JOIN permissions ON users.id = permissions.user_id INNER JOIN pools ON pools.id = permissions.pool_id').where("profile_type = 'Doctor' or profile_id = ?", params[:id]).order("permissions.user_id ASC").uniq.all
			#.joins(:user, :pool).where("profile_type = 'Doctor'").select(:name).uniq.all
			@pools = Pool.joins(:permissions).where("user_id = ?", current_user.id).uniq.all
			
		end		
	end
	def update
		#finds the patient from the current params hash.
		@patient = Patient.find(params[:id])
		#gets the user from the patient that was found
		#checks to see what button was pressed in the displayed list, the add and remove are strictly for the Admins interaction with the edit page, the update is for when a patient wants to change his information
		if defined?(params[:patient][:func]) &&params[:patient][:func] != nil

		if(params[:patient][:func] == "addDoc")
				@patient.update_attribute(:doctor_id, params[:patient][:doctor_id])
				@patient.update_attribute(:accepted, false)
				redirect_to edit_patient_path(@patient,{settings: "AvailableDocs"})
			elsif(params[:patient][:func] == "removeDoc")
				@patient.update_attribute(:doctor_id, nil)
				@patient.update_attribute(:accepted, false)
				redirect_to edit_patient_path(@patient, {settings: "AvailableDocs"})
			elsif(params[:patient][:func] == "addPool")
				@perm = Permission.new
				@perm.user_id = @user.id
				@perm.pool_id = params[:patient][:pool_id]
				if @perm.save
					flash[:notice]="permissions updated"
				else
					flash[:alert]="a problem occurred updating the users permissions"
				end
				redirect_to edit_patient_path(@patient,{settings: "AdjustPools"})
			elsif(params[:patient][:func] == "removePool")			
				Permission.where("user_id = ? AND pool_id = ?",@user.id, params[:patient][:pool_id]).delete_all
				flash[:notice]="removed patients' permission from pool"
				redirect_to edit_patient_path(params[:id],{settings: "AdjustPools"})
			elsif(params[:patient][:func] == "addNotes")
				@patient.update_attribute(:doctorNotes, params[:patient][:doctorNotes])
				redirect_to @patient
			else 
			flash[:alert]="problem updating"
			redirect_to @patient
			end
		else	
		
			if defined?(params[:user][:old_password]) && @user.authenticate(params[:user][:old_password])
				@user = @patient.user
				@user.update(user_params)
				flash[:notice]="successfully updated your profile."
				redirect_to @patient
				
			elsif defined?(params[:patient][:weight])
				if @patient.update_attributes(patient_params)				
					flash[:notice]="successfully updated your profile."
					redirect_to @patient	
				else 
					flash[:alert]="error updating your profile."
					render 'edit'
				end
			else
				flash[:alert]="error updating your profile."
				render 'edit'
			end	
		end
		
	end
	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
		def patient_params
			params.require(:patient).permit(:emergencyContact, :emergencyPhoneNumber, 
			:dateOfBirth, :healthCardNumber, :phoneNumber, :weight, :height, :currentMedication,
			:currentIssue, :familyDoctor,:doctorNotes)
		end
		#before filters
		def signed_in
			unless signed_in?
				store_location
				redirect_to signin_url, notice: "Please sign in."
			end
		end
		def signed_in_admin
			if signed_in? #checks if the user is currently signed in, the function is housed in the sessions helper for in depth analy sis
				unless is_admin #checks if the currently logged in user is an Admin
				
				redirect_to signin_url, notice: "You do not have permission to do that."
				end
			else
				store_location
				redirect_to signin_url, notice: "Please sign in." #signin_url is implicitly defined in the config/routes.rb file
			end
		end
		def correct_user
			#checks params hash for the user id storing that user into a variable
			@profile = Patient.find(params[:id])
			@user = @profile.user
			#compares that user created above to the currently logged in user
			unless current_user?(@user) ||(is_admin && !is_director) || (@profile.doctor_id == current_user.profile_id && current_user.profile_type =="Doctor")
			flash[:alert]="you do not have permission to do that. " 
			redirect_to(admins_path({user_type: "Admin"}))  
			end
		end
end
