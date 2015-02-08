class AdminsController < ApplicationController
	#performs a before action, in other words it will run the script defined at the start method-> :signed_in_admin
	#this will then run before every POST action that exists after -> :new, :create, :index, :edit, :update
	before_action :signed_in_admin, only: [:new,:create,:index,:edit, :update]
	#before_action :correct_user, only: [:show, :edit, :update]
	before_action :signed_in, only: [:show, :edit, :update]
	def show
		@admin = Admin.find(params[:id]) 
		@user = @admin.user
	end
	def index
	#puts all of the admins into a browsable list
	#the list has a default length of 30 entries per page 
	#uses will_paginate in the view to put the page bar in
		@admins =User.paginate(page: params[:page])
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
		@admin.director =false
		#tries to save the admin to the database
		if  @admin.save
			#flashes a success message for the admin
			flash[:success]
			#redirects to the newly created admins' page
			redirect_to edit_doctor_path(@admin)
		else
			#reloads the new page so that the forms can have the correct information
			render 'new'
		end
	end
	def edit
		#finds the user that is defined in the param hash and finds that user
		@admin = Admin.find(params[:id])
		#using the profile found above will then get the user of that admin aka the email, username, etc
		@user = @admin.user
		@pools = Pool.all

	end
	def update
		@admin = Admin.find(params[:id])
		@user = @admin.user
		if defined?(params[:admin][:func])
			if(params[:admin][:func] == "addPool")
				@perm = Permission.new
				@perm.user_id = @user.id
				@perm.pool_id = params[:admin][:pool_id]
				if @perm.save
					flash[:success]="permissions updated"
				else
					flash[:error]="a problem occurred updating the users permissions"
				end
				redirect_to edit_admin_path(@admin)
			elsif(params[:admin][:func] == "removePool")
				
				Permission.where("user_id = ? AND pool_id = ?",@user.id, params[:admin][:pool_id]).delete_all
				flash[:success]="removed admins permission from pool"
				redirect_to edit_admin_path(params[:id])
			end
		else
			if @user.authenticate(params[:user][:old_password])
				#passes the attributes from the form to the admin_params function
				@admin.update_attributes(admin_params)
				#passes the attributes from the form to the user_params function
				@user.update_attributes(user_params)
				flash[:success]="successfully updated your profile."
				redirect_to @admin
			else
				flash[:failure]="error updating your profile."
				render 'edit'
			end
		end
	end
	private
	#params
	#used to specify which attributes of the model should be accepted
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
		def admin_params
			
		end
		#before filters
		#functions called at the start of various actions. to see which is called by what function check first few lines of this code with before_action
		def signed_in
			if signed_in?#checks if the user is currently signed in, the function is housed in the sessions helper for in depth analysis
			else
				store_location
				redirect_to signin_url, notice: "Please sign in."
			end
		end
		#checks if the currently signed in user is an admin
		def signed_in_admin
			if signed_in? #checks if the user is currently signed in, the function is housed in the sessions helper for in depth analysis
				if current_user.profile_type=="Admin" #checks if the currently logged in user is an Admin
				else
					redirect_to signin_url, notice: "You do not have permission to do that."
				end
			else
				store_location
				redirect_to signin_url, notice: "Please sign in." #signin_url is implicitly defined in the config/routes.rb file
			end
		end
		
		#checks that the user that is logged in matches the id of the user that is in the params hash matches that which is currently logged in
		def correct_user
			#checks params hash for the user id storing that user into a variable
			@user = User.find(params[:id])
			#compares that user created above to the currently logged in user
			redirect_to(root_url) unless current_user?(@user)
		end
end
