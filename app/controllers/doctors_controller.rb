class DoctorsController < ApplicationController
	#performs a before action, in other words it will run the script defined at the start method-> :signed_in_admin
	#this will then run before every POST action that exists after -> :new, :create
	before_action :signed_in, only: [:show,:edit, :update]
	before_action :signed_in_admin, only: [:new, :create]
	before_action :correct_user, only: [:edit, :update]
	before_action :correct_doctor, only: [:index]
	before_action :viewable, only: [:show]
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	def index
		#puts all of the doctors into a browsable list
		#the list has a default length of 30 entries per page 
		#uses will_paginate in the view to put the page bar in
		@doctor=Doctor.find(params[:id])
		if params[:patient_status]=="Accepted"
		@acceptedStatus=true
		elsif params[:patient_status]=="Rejected"
		@acceptedStatus=false
		else
		@acceptedStatus=nil
		end
		if @acceptedStatus.nil?
		@patients=Patient.joins("INNER JOIN doc_relationships ON patients.id = doc_relationships.patient_id INNER JOIN users on patients.id = users.profile_id AND users.profile_type='Patient'").where("doctor_id= ? and accepted is null",@doctor.id).select("doc_relationships.accepted,doc_relationships.patient_id,doc_relationships.doctor_id, patients.id") #@doctor.patients.paginate(page: params[:page])
		else
		@patients=Patient.joins("INNER JOIN doc_relationships ON patients.id = doc_relationships.patient_id").where("doctor_id= ? and accepted = ?",@doctor.id,@acceptedStatus).select("doc_relationships.accepted,doc_relationships.patient_id,doc_relationships.doctor_id, patients.id") #@doctor.patients.paginate(page: params[:page])
		end
		#@docRelation=@doctor.doc_relationships
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
		#tries to save the doctor to the database
		if @doctor.save		
		@user = @doctor.build_user(user_params)
        if @user.save
			#flashes a success message for the doctor		
			flash[:notice]="Doctor saved successfully."
			#redirects to the pools index page
			redirect_to users_path({:user_type => "Doctor"})
        else
          render 'new'
        end
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
		if defined?(params[:doctor][:func])
			if( params[:doctor][:func] == "accept")
				#
				@docRelationship=DocRelationship.where('doctor_id=? and patient_id=?', params[:doctor][:doctor_id], params[:doctor][:patient_id]).first
				#updates the doctors patient that had the accepted sent with a true value
				@docRelationship.update_attribute(:accepted, true)
				redirect_to doctors_path(id: @doctor,patient_status: "Pending" )
			elsif(params[:doctor][:func] == "reject")
				#
				@patient=Patient.find(params[:doctor][:patient_id])
				@docRelationship=DocRelationship.where('doctor_id=? and patient_id=?', params[:doctor][:doctor_id], params[:doctor][:patient_id]).first
				#updates the doctors patient that had the accepted sent with a true value
				@docRelationship.update_attribute(:accepted, false)

				
				#removes the doctors id from the patient with the request
				#sets the accepted value of the patient from the current doctor to false
				redirect_to doctors_path(id: @doctor,patient_status: "Pending")
=begin            elsif(params[:doctor][:func] == "addPool")
				@user = @doctor.user
				@perm = Permission.new
				@perm.user_id = @user.id
				@perm.pool_id = params[:doctor][:pool_id]
				if @perm.save
					flash[:notice]="permissions updated"
				else
					flash[:alert]="a problem occurred updating the users permissions"
				end
				redirect_to edit_doctor_path(@doctor)
			elsif(params[:doctor][:func] == "removePool")		
				@user = @doctor.user			
				Permission.where("user_id = ? AND pool_id = ?",@user.id, params[:doctor][:pool_id]).delete_all
				flash[:notice]="removed doctors' permission from pool"
=end				redirect_to edit_doctor_path(params[:id])
			end
		else
				@user = @doctor.user

			if @user.authenticate(params[:user][:old_password])
                                #passes the attributes from the form to the admin_params function
                                if(params[:user][:email].match(VALID_EMAIL_REGEX))
                                         if defined?(params[:user][:password]) || defined?(params[:user][:password_confirmation])
                                                 if (params[:user][:password] != params[:user][:password_confirmation])
                                                         flash[:alert]="Password and Password Confirmation must match"
                                                         render 'edit'
                                                else

                                                        @doctor.update_attributes(doctor_params)
        #passes the attributes from the form to the user_params function
                                                        @user.update_attributes(user_params)
                                                        flash[:notice]="successfully updated your profile."
                                                        redirect_to @doctor

                                                end
                                        else
                                                @doctor.update_attributes(doctor_params)
        #passes the attributes from the form to the user_params function
                                                        @user.update_attributes(user_params)
                                                        flash[:notice]="successfully updated your profile."
                                                        redirect_to @doctor
                                        end
                                else
                                        flash[:alert]="Please enter a valid email"
                                        render 'edit'
                                end
                        else
                                flash[:alert]="Old password is not corrent"
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
				unless is_admin && !is_director#checks if the currently logged in user is an Admin
                flash[:alert]="you do not have permission to create a doctor."
                  redirect_to go_to_home
				end
			else
				store_location
				redirect_to signin_url, notice: "Please sign in." 
			end
		end
		#checks that the user that is logged in matches the id of the user that is in the params hash matches that which is currently logged in
		def correct_user
			#checks params hash for the user id storing that user into a variable
			@doctor = Doctor.find(params[:id])
			#compares that user created above to the currently logged in user
			
			unless current_user?(@doctor.user) || is_admin
				@doctor = nil
				flash[:alert] = "You do not have permission to edit this doctor"
				redirect_to(root_url) 
			end
		end
		def correct_doctor
			if is_patient || is_director
				 flash[:alert] = "You do not have permission do view this doctors patients."
                                redirect_back_or(signin_url)
			elsif is_doctor
				@doctor =Doctor.find(params[:id])
				unless current_user?(@doctor.user) 
					flash[:alert] = "You do not have permission do view this doctors patients."
					redirect_back_or(signin_url)
				end
			end
		end
		def viewable
			@doctor =Doctor.find(params[:id])
			if is_patient
				@patient = DocRelationship.where("doctor_id=? and patient_id=?",@doctor.id,current_user.profile_id).first
			end

# this needs to be fixed so that only accepted patients can view the doctor profile
			unless current_user?(@doctor.user) || is_admin ||is_doctor # (defined?(@patient) && @patient.accepted)
				@doctor = nil
				flash[:alert] = "You do not have permission do view this doctor."
				redirect_to(root_url) 
			end
		end
end
