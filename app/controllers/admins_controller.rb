class AdminsController < ApplicationController
	before_action :signed_in_admin, only: [:new,:create,:index,:edit, :update]
	before_action :correct_user, only: [:edit, :update]
	def show
		@admin = Admin.find(params[:id])
		@user = @admin.user
	end
	def index
	#puts all of the admins into a browsable list
		@users =User.all
	end
	def new
		#creates temp variables for the new form to use for the views
		@admin =Admin.new
		@user = User.new
	end
	def create
		#creates the admin based on the allowed admin parameters
		@admin =Admin.new(admin_params)
		#creates a user and attaches it to the admin with the user parameter restrictions required
		@user = @admin.build_user(user_params)
		#tries to save the admin to the database
		if  @admin.save
			flash[:success]
			redirect_to @admin
		else
			render 'new'
		end
	end
	def edit
		@admin = Admin.find(params[:id])
		@user = @admin.user
	end
	def update
		@admin.update_attributes(admin_params)
		@user.update_attributes(user_params)
	end
	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
		def admin_params
			
		end
		#before filters
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
