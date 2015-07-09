class UsersController < ApplicationController
#ignore this file, we will need to delete this later on since a user should not be actionable
#check patient, doctor, or admin controller for the actual implementation. I'm leaving this in
#so i dont have to make a bunch of changes to other code right now, will fix l8r
	before_action :signed_in_user, only: [:index,:edit, :update]
	before_action :correct_user, only: [:edit, :update]
	def index
     if defined? params[:search]
		unless is_director | is_doctor
            @users = User.where('name LIKE ? and profile_type = ?',"%#{params[:search]}%",params[:user_type]).order("name ASC").paginate(page: params[:page])
        else
			if params[:user_type] != "Patient"
              @users = User.where('name LIKE ? and profile_type = ?',"%#{params[:search]}%",params[:user_type]).order("name ASC").paginate(page: params[:page])
			else
              if is_doctor

      #          @user = Patient.joins(doc_relationships: :patient_id)#.where('name LIKE ? and profile_type = ? && doc_id = ?',"%#{params[:search]}%",params[:user_type], (Doctor.find(current_user.profile_id).id))
     #       @patients=Patient.joins("inner join doc_relationships on patients.id = doc_relationships.patient_id").where("doctor_id= ?",Doctor.find(current_user.profile_id).id).all #@doctor.patients.paginate(page: params[:page])
	          
              @users = User.where('name LIKE ? and profile_type = ?',"%#{params[:search]}%",params[:user_type]).order("name ASC").paginate(page: params[:page])
			else
			
				flash[:notice] = "You do not have permission to view patients"
			  end
            end
		end

          render 'index'
	end
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
    unless is_director
        @pools = Pool.joins(:permissions).where("user_id = ?", current_user.id).uniq.all
    else
      @pools = Pool.all
    end
	if(is_admin && @user.profile_type = "Patient")
			@SelDocs= User.joins('INNER JOIN permissions ON users.id = permissions.user_id INNER JOIN pools ON pools.id = permissions.pool_id INNER JOIN doc_relationships ON users.profile_id = doc_relationships.doctor_id')
			@SelDocs=@SelDocs.where("profile_type = 'Doctor' and doc_relationships.patient_id = ?", params[:id])
			@SelDocs=@SelDocs.select("permissions.user_id, users.name, users.profile_id,users.profile_type, users.id,doc_relationships.doctor_id,doc_relationships.patient_id,doc_relationships.accepted")
			@SelDocs=@SelDocs.order("permissions.user_id ASC").uniq
			@SelRelations= User.joins('INNER JOIN permissions ON users.id = permissions.user_id INNER JOIN pools ON pools.id = permissions.pool_id LEFT OUTER JOIN doc_relationships ON users.profile_id = doc_relationships.doctor_id').where("profile_type = 'Doctor' ").select("permissions.user_id, users.name, users.profile_id,users.profile_type, users.id,doc_relationships.doctor_id,doc_relationships.patient_id,doc_relationships.accepted").order("permissions.user_id ASC").group("permissions.user_id, users.name, users.profile_id,users.profile_type, users.id,doc_relationships.doctor_id,doc_relationships.patient_id,doc_relationships.accepted").uniq.all
			@doctors =  @SelDocs | @SelRelations
			@pools = Pool.joins(:permissions).where("user_id = ?", current_user.id).uniq	
    end	
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
                      	flash[:notice]="removed admins permission from pool"
    				else
	    				flash[:alert]="a problem occurred updating the users permissions"
		    		end
                  
              else
                     flash[:notice] = "You do not have permission to add users to this pool"
              end
		        	redirect_to edit_user_path(params[:id])
             elsif params[:user][:func] == "removePool"
              	Permission.where("user_id = ? AND pool_id = ?",@user.id, params[:user][:pool_id]).delete_all
				flash[:notice]="removed admins permission from pool"
				redirect_to edit_user_path(params[:id])
            else
              render 'edit'
            end
		elsif @user.update_attributes(user_params) && current_user
			flash[:success]="Profile updated"
			redirect_to edit_user_path(params[:id])
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
			redirect_to(root_url) unless (current_user?(@user) || is_admin)
            if is_director?(current_user) && is_patient?(@user)
                flash[:notice] = "You do not have permissions to modify patient permissions"
                	redirect_to(root_url) 
            end
        end
		
end
