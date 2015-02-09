class DoctorsController < ApplicationController
	#performs a before action, in other words it will run the script defined at the start method-> :signed_in_admin
	#this will then run before every POST action that exists after -> :new, :create
	before_action :signed_in, only: [:show,:edit, :update]
	before_action :signed_in_admin, only: [:new, :create]
	before_action :correct_user, only: [:show,:edit, :update]
	before_action :correct_doctor, only: [:index]
	def index
		#puts all of the doctors into a browsable list
		#the list has a default length of 30 entries per page 
		#uses will_paginate in the view to put the page bar in
		@doctor=Doctor.find(params[:id])
		@patients=@doctor.patients.paginate(page: params[:page])
	end
	def show
		#looks up the user that has the id in the params hash
		@doctor = Doctor.find(params[:id])
		@user = @doctor.user
		@patients=@doctor.patients
	end
	def new
		#creates variables for the views to initialize
		@doctor = Doctor.new
		@user = User.new
	end
	def create
		#this should call the create function from the user controller
		#creates the doctor based on the allowed doctor parameters
		@doctor =Doctor.new(doctor_params)
		#creates a user and attaches it to the doctor with the user parameter restrictions required
		@user = @doctor.build_user(user_params)
		#tries to save the doctor to the database
		if @doctor.save		
			#flashes a success message for the doctor		
			flash[:success]
			#redirects to the pools index page
			redirect_to edit_doctor_path(@doctor)
		else
			#reloads the new page so that the forms can have the correct information
			render 'new'
		end
	end
	def edit
		#finds the user id that is defined in the param hash and finds that user based on that id
		@doctor = Doctor.find(params[:id])
		#using the profile found above will then get the user of that doctor aka the email, username, etc
		@user = @doctor.user
		@pools = Pool.joins(:permissions).where("user_id = ?", current_user.id).uniq.all

	end
	def update
		@doctor = Doctor.find(params[:id])
		@user = @doctor.user
		if defined?(params[:doctor][:func])
			if( params[:doctor][:func] == "accept")
				#
				@patient=Patient.find(params[:doctor][:patient_id])
				#updates the doctors patient that had the accepted sent with a true value
				@patient.update_attribute(:accepted, true)
				redirect_to doctors_path(id: @doctor)
			elsif(params[:doctor][:func] == "reject")
				#
				@patient=Patient.find(params[:doctor][:patient_id])
				#removes the doctors id from the patient with the request
				@patient.update_attribute(:doctor_id, nil)
				#sets the accepted value of the patient from the current doctor to false
				@patient.update_attribute(:accepted, false)
				redirect_to doctor_path(@doctor)
			elsif(params[:doctor][:func] == "addPool")
				@perm = Permission.new
				@perm.user_id = @user.id
				@perm.pool_id = params[:doctor][:pool_id]
				if @perm.save
					flash[:success]="permissions updated"
				else
					flash[:error]="a problem occurred updating the users permissions"
				end
				redirect_to edit_doctor_path(@doctor)
			elsif(params[:doctor][:func] == "removePool")			
				Permission.where("user_id = ? AND pool_id = ?",@user.id, params[:doctor][:pool_id]).delete_all
				flash[:success]="removed doctors' permission from pool"
				redirect_to edit_doctor_path(params[:id])
			end
		else
			if @user.authenticate(params[:user][:old_password])
				@doctor.update(doctor_params)
				@user.update(user_params)
				flash[:success]="successfully updated your profile."
				redirect_to @doctor
			else
				flash[:failure]="error updating your profile."
				render 'edit'
			end			
			#redirect_to doctor_path(@doctor)
		end
		#redirects to the current doctors home page
		
	end
	private
	#params
	#used to specify which attributes of the model should be accepted
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
		def doctor_params
		end
		#before filters
		#functions called at the start of various actions. to see which is called by what function check first few lines of this code with before_action
		def signed_in
			unless signed_in?#checks if the user is currently signed in, the function is housed in the sessions helper for in depth analysis
				store_location
				redirect_to signin_url, notice: "Please sign in."
			end
		end
		def signed_in_admin
			if signed_in?#checks if the user is currently signed in, the function is housed in the sessions helper for in depth analysis
				if current_user.profile_type=="Admin"#checks if the currently logged in user is an Admin
				else
				redirect_to signin_url, notice: "You do not have permission to do that." #signin_url is implicitly defined in the config/routes.rb file
				end
			else
				store_location
				redirect_to signin_url, notice: "Please sign in." 
			end
		end
		#checks that the user that is logged in matches the id of the user that is in the params hash matches that which is currently logged in
		def correct_user
			#checks params hash for the user id storing that user into a variable
			@user = User.find(params[:id])
			#compares that user created above to the currently logged in user
			redirect_to(root_url) unless current_user?(@user)
		end
		def correct_doctor
			if params[:id].to_i != current_user.profile_id
				flash[:error] = "You do not have permission do view this doctors patients"
				redirect_back_or(signin_url)
			end
		end
end
