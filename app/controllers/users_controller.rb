class UsersController < ApplicationController
#ignore this file, we will need to delete this later on since a user should not be actionable
#check patient, doctor, or admin controller for the actual implementation. I'm leaving this in
#so i dont have to make a bunch of changes to other code right now, will fix l8r
	before_action :signed_in_user, only: [:index,:edit, :update]
	before_action :correct_user, only: [:edit, :update]
	def index
     if defined? params[:search]
		unless is_director
			@users = User.where('name LIKE ? and profile_type = ?',"%#{params[:search]}%",params[:user_type]).order("name ASC").paginate(page: params[:page])
		else
			if params[:user_type] != Patient	
			@users = User.where('name LIKE ? and profile_type = ?',"%#{params[:search]}%",params[:user_type]).order("name ASC").paginate(page: params[:page])
			else
				flash[:notice] = "You do not have permission to view patients"
			end
		end
	end
     redirect_to root_url
    end
	def show
		@user = User.find(params[:id])
	end
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render 'new'
		end


	end
	def edit
	@user = User.find(params[:id])
	end
	def update
      
		@user = User.find(params[:id])
		if defined?(params[:user][:func]) && is_admin
            if(params[:user][:func] == "addPool")
              @pool = Pool.find(params[:user][:pool_id])
               if @pool.users.include?(current_user) || is_director?(current_user)
                    @perm = Permission.new	
  	    			@perm.user_id = @user.id
    				@perm.pool_id = params[:user][:pool_id]
			
                  if @perm.save
			    		flash[:notice]="permissions updated"
    				else
	    				flash[:alert]="a problem occurred updating the users permissions"
		    		end
              else
              flash[:notice] = "You do not have permission to add users to this pool"
              end
                  redirect_to @user
             elsif params[:user][:func] == "removePool"
              	Permission.where("user_id = ? AND pool_id = ?",@user.id, params[:user][:pool_id]).delete_all
				flash[:notice]="removed admins permission from pool"
				redirect_to @user
            else
              render 'edit'
            end
		elsif @user.update_attributes(user_params) && current_user
			flash[:success]="Profile updated"
			redirect_to @user
		else
			render 'edit'
		end
	end
	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
		#before filters
		def signed_in_user
			unless signed_in?
				store_location
				redirect_to signin_url, notice: "Please sign in."
			end
		end
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user) || is_admin
            if is_director?(current_user) && is_patient?(@user)
                flash[:notice] = "You do not have permissions to modify patient permissions"
                	redirect_to(root_url) 
            end
        end
		
end
