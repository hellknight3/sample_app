class PatientsController < ApplicationController
	helper UsersHelper
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	#performs a before action, in other words it will run the script defined at the start method-> :signed_in_admin
	#this will then run before every POST action that exists after -> :new, :create, :edit, :update
	before_action :signed_in, only: [:edit, :update]
	before_action :signed_in_admin, only: [:new, :create]
	before_action :correct_user, only: [:show,:edit, :update]
	def show
		#shows the current users properties
		@patient = Patient.find(params[:id])
		@user = @patient.user
                              Activity.create(:user => current_user,:trackable => @patient,:action => "SHOW") 
		@doctors=Doctor.joins("INNER JOIN doc_relationships ON doctors.id = doc_relationships.doctor_id").where("patient_id= ? and accepted = ?",@patient.id,true).select("doc_relationships.accepted,doc_relationships.patient_id,doc_relationships.doctor_id, doctors.id")#@doctor.patients.paginate(page: params[:page])

	end
	def new
		#creates variables for the views to initialize
		@patient = Patient.new
		@user = User.new
	end
	def create
		#creates the patient based on the allowed patient parameters
		@patient =Patient.new(patient_params)
		#tries to save the patient to the database
		if @patient.save
          #creates a user and attaches it to the patient with the user parameter restrictions required
          #since the association exists between user and patient, build_user handles the whole process, but acts like a new command
          @user = @patient.build_user(user_params)
          if @user.save
              #flashes a success message for the admin		
              flash[:notice] ="successfully added patient"
              #redirects to the pool index page
            InstitutionMembership.create(:institution => current_user.institutions.first, :memberable => @user)
              Activity.create(:user => current_user,:trackable => @patient,:action => "CREATE",:message => "Created patient #{@user.name}")
              redirect_to edit_user_path(@patient.user)
          else
              @patient.delete
              flash[:alert]="error creating patient"
              render 'new'
          end
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
		@note = Note.new
		if(is_admin)
			#if the current user is an admin it will create a doctor variable finding all the user profiles with a profile_type of doctor in the database
			#@doctors=User.find(:all, :conditions => ["profile_type = :doc",{:doc => 'Doctor'}])
			#@availableDocs= @doctors.pools.users.where("profile_type: = ?","Doctor").uniq.all
			@SelDocs= User.joins('INNER JOIN permissions ON users.id = permissions.user_id INNER JOIN pools ON pools.id = permissions.pool_id INNER JOIN doc_relationships ON users.profile_id = doc_relationships.doctor_id')
			@SelDocs=@SelDocs.where("profile_type = 'Doctor' and doc_relationships.patient_id = ?", params[:id])
			@SelDocs=@SelDocs.select("permissions.user_id, users.name, users.profile_id,users.profile_type, users.id,doc_relationships.doctor_id,doc_relationships.patient_id,doc_relationships.accepted")
			@SelDocs=@SelDocs.order("permissions.user_id ASC").uniq
			@SelRelations= User.joins('INNER JOIN permissions ON users.id = permissions.user_id INNER JOIN pools ON pools.id = permissions.pool_id LEFT OUTER JOIN doc_relationships ON users.profile_id = doc_relationships.doctor_id').where("profile_type = 'Doctor' ").select("permissions.user_id, users.name, users.profile_id,users.profile_type, users.id,doc_relationships.doctor_id,doc_relationships.patient_id,doc_relationships.accepted").order("permissions.user_id ASC").group("permissions.user_id, users.name, users.profile_id,users.profile_type, users.id,doc_relationships.doctor_id,doc_relationships.patient_id,doc_relationships.accepted").uniq
			@doctors =  @SelDocs | @SelRelations
			#.joins(:user, :pool).where("profile_type = 'Doctor'").select(:name).uniq.all
			@pools = Pool.joins(:permissions).where("user_id = ?", current_user.id).uniq
			
		end		
	end
	def update

		
		#finds the patient from the current params hash.
		@patient = Patient.find(params[:id])
		#gets the user from the patient that was found
		#checks to see what button was pressed in the displayed list, the add and remove are strictly for the Admins interaction with the edit page, the update is for when a patient wants to change his information
		
	    if defined?(params[:patient][:func])
		  if(params[:patient][:func] == "addNotes")
			@patient.update_attribute(:doctorNotes, params[:patient][:doctorNotes])
			redirect_to @patient
	      else 
			flash[:alert]="problem updating"
			redirect_to @patient
		  end
		else	
							
			if defined?(params[:user][:old_password]) && @user.authenticate(params[:user][:old_password])
			 if(params[:user][:email].match(VALID_EMAIL_REGEX))
				if defined?(params[:user][:password]) || defined?(params[:user][:password_confirmation])
					if (params[:user][:password] != params[:user][:password_confirmation])
						 flash[:alert]="Password and Password Confirmation must match"
                                        	render 'edit'
					else	
                         if params[:user][:password_confirmation] != ""
                        #passes the attributes from the form to the user_params function
			    	    @user.update_attributes(user_params)
                         else
                           values = {:name => params[:user][:name], :password_confirmation => params[:user][:old_password], :email => params[:user][:email], :password => params[:user][:old_password]}
                            if @user.update_attributes(values)
                              Activity.create(:user => current_user,:trackable => @patient,:action => "UPDATE") 
                            end
                            
						flash[:notice]="successfully updated your profile."
						redirect_to @patient
                         end
					end
				else
					user = @patient.user
              	                 	 @user.update(user_params)
                              Activity.create(:user => current_user,:trackable => @patient,:action => "UPDATE") 
                	                flash[:notice]="successfully updated your profile."
                        	        redirect_to @patient

				end
			else
				 flash[:alert]="Please enter a valid email"
                                                render 'edit'
			end

				
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
				unless is_admin && !is_director #checks if the currently logged in user is an Admin
				
				redirect_to go_to_home, alert: "You do not have permission to do that."
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
			@docRelation=DocRelationship.where("doctor_id=? and patient_id=?",current_user.profile_id,@profile.id).size
	
			unless current_user?(@user) || (@docRelation >0 && current_user.profile_type =="Doctor")
			flash[:alert]="you do not have permission to do that. " 
            redirect_to go_to_home, alert: "permissions denied" 
			#redirect_to(admins_path({user_type: "Admin"}), alert: "you do not have permission to do that.")
			end
	
		end
end
