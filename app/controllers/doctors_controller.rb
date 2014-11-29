class DoctorsController < ApplicationController

	before_action :signed_in, only: [:show,:edit, :update]
	before_action :signed_in_admin, only: [:new, :create]
	#before_action :correct_user, only: [:show,:edit, :update]
	def index
		#will need to figure out how to restrict the information
		#this will make it so a list of users is created and displayed similar to how facebook displays users
		#paginate restricts the amount that is returned in the result, i believe the default is 30 rows/users
		#this also would not function since i have removed it in the before filter.
		@doctor=Doctor.find(params[:id])
		@patients=@doctor.patients.paginate(page: params[:page])
	end
	def show
		#looks up the user that has the id in the params hash
		@doctor = Doctor.find(params[:id])
		@user = @doctor.user
		
		
	end
	def new
		#creates variables for the views to initialize
		@doctor = Doctor.new
		@user = User.new
	end
	def create
		#this should call the create function from the user controller, i don't know if i have to do anything special to make it work though. can't get fully functional implementation until the Views are set up.
		@doctor =Doctor.new(doctor_params)
		@user = @doctor.build_user(user_params)
		if @doctor.save			
			flash[:success]
			redirect_to pools_path
		else
			render 'new'
		end
	end
	def edit
		@doctor = Doctor.find(params[:id])
		@user = @doctor.user
	end
	def update
		@doctor = Doctor.find(params[:id])
		@user = @doctor.user
		if(params[:doctor][:func] == "accept")
			@patient=Patient.find(params[:doctor][:patient_id])
			@patient.update_attribute(:accepted, true)
		elsif(params[:doctor][:func] == "reject")
			@patient=Patient.find(params[:doctor][:patient_id])
			@patient.update_attribute(:doctor_id, nil)
			@patient.update_attribute(:accepted, false)
		else
			@doctor.update(doctor_params)
			@user.update(user_params)	
		end
		redirect_to doctor_path(@doctor)
	end
	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
		def doctor_params
		end
		#before filters
		def signed_in
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
