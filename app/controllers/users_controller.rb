class UsersController < ApplicationController
	before_action :signed_in_user, only: [:index,:edit, :update]
	before_action :correct_user, only: [:edit, :update]
	def index
      #implementing the search mechanism for the user index
      if defined? params[:search]
        unless is_director | is_doctor
          @users = User.where('name LIKE ? and profile_type = ?',"%#{params[:search]}%",params[:user_type]).order("name ASC").paginate(page: params[:page])
        else
          if params[:user_type] != "Patient"
            @users = User.where('name LIKE ? and profile_type = ?',"%#{params[:search]}%",params[:user_type]).order("name ASC").paginate(page: params[:page])
          else
            if is_doctor
              @users = User.where('name LIKE ? and profile_type = ?',"%#{params[:search]}%",params[:user_type]).order("name ASC").paginate(page: params[:page])
            else
              flash[:notice] = "You do not have permission to view patients"
            end
          end
        end
        render 'index'
      end
    end
    
	def edit
      @user = User.find(params[:id])
      unless is_director
        @pools = Pool.joins(:permissions).where("user_id = ?", current_user.id).uniq
      else
        @pools = Pool
      end
      if(is_admin && @user.profile_type = "Patient")
        @SelDocs= User.joins('INNER JOIN permissions ON users.id = permissions.user_id INNER JOIN pools ON pools.id = permissions.pool_id INNER JOIN doc_relationships ON users.profile_id = doc_relationships.doctor_id')
        @SelDocs=@SelDocs.where("profile_type = 'Doctor' and doc_relationships.patient_id = ?", params[:id])
        @SelDocs=@SelDocs.select("permissions.user_id, users.name, users.profile_id,users.profile_type, users.id,doc_relationships.doctor_id,doc_relationships.patient_id,doc_relationships.accepted")
        @SelDocs=@SelDocs.order("permissions.user_id ASC").uniq
        @SelRelations= User.joins('INNER JOIN permissions ON users.id = permissions.user_id INNER JOIN pools ON pools.id = permissions.pool_id LEFT OUTER JOIN doc_relationships ON users.profile_id = doc_relationships.doctor_id').where("profile_type = 'Doctor' ").select("permissions.user_id, users.name, users.profile_id,users.profile_type, users.id,doc_relationships.doctor_id,doc_relationships.patient_id,doc_relationships.accepted").order("permissions.user_id ASC").group("permissions.user_id, users.name, users.profile_id,users.profile_type, users.id,doc_relationships.doctor_id,doc_relationships.patient_id,doc_relationships.accepted").uniq
        @doctors =  @SelDocs | @SelRelations
        @pools = Pool.joins(:permissions).where("user_id = ?", current_user.id).uniq	
      end	
    end
	def update
      
      @user = User.find(params[:id])
      #this first section is for admins to update doctor and patient relationships
      if defined?(params[:user][:func]) && is_admin
        #if the logged in user is trying to add the selected user to a pool
        if(params[:user][:func] == "addPool")
          @pool = Pool.find(params[:user][:pool_id])
          #if the current user is an admin and wants to add a user to a pool they are in or if the user is a director
          if @pool.users.include?(current_user) || is_director?(current_user)
            #adds the user to the pool
            @perm = Permission.new	
            @perm.user_id = @user.id
            @perm.pool_id = params[:user][:pool_id]

            if @perm.save
              #creates a log entry that the current user has added the selected user to a specific pool
              Activity.create(:user => current_user,:trackable => @pool,:action => "ADD PERMISSION", :message => "added the pool #{@pool.name} to #{@user.name}") 
              flash[:notice]="permissions updated"
              flash[:notice]="removed admins permission from pool"
            else
              #in the event that invalid information is passed
              flash[:alert]="a problem occurred updating the users permissions"
            end
          else
            #if the current user is an admin but not in the pool they want to add
            flash[:notice] = "You do not have permission to add users to this pool"
          end
          redirect_to edit_user_path(params[:id])
        elsif params[:user][:func] == "removePool"
          #remove the selected user from the pool
          @pool=Pool.find(params[:user][:pool_id])
          Permission.where("user_id = ? AND pool_id = ?",@user.id, @pool.id).delete_all
          Activity.create(:user => current_user,:trackable => @pool,:action => "REMOVE PERMISSION",:message => "#{current_user.name} removed pool #{@pool.name} from #{@user.name}")
          flash[:notice]="removed admins permission from pool"
          redirect_to edit_user_path(params[:id])
        elsif(params[:user][:func] == "addDoc")

          @docRelationship=DocRelationship.where('doctor_id=? and patient_id=?', params[:user][:doctor_id], params[:user][:patient_id]).first
          #adds a doctor to a given patient, the doctor then has to confirm the patient as theirs
          #overrides previous doctor relationships
          if @docRelationship
            @docRelationship.update_attribute(:accepted, nil)
            @doctor=Doctor.find(params[:user][:doctor_id])
            @patient=User.find(params[:user][:patient_id]).profile
            Activity.create(:user => current_user, :trackable => @patient,:action => "Added Doctor",:message => "#{current_user.name} added #{@doctor.user.name} as #{@patient.user.name}'s doctor")
          else
            #creates a new relationship for a patient with a doctor, the doctor must still accept the patient
            @newRelationship=DocRelationship.new
            @newRelationship.doctor_id = params[:user][:doctor_id]
            @newRelationship.patient_id= params[:user][:patient_id]
            @newRelationship.accepted= nil
            if @newRelationship.save
              @doctor=Doctor.find(params[:user][:doctor_id])
              @patient=User.find(params[:user][:patient_id]).profile
              Activity.create(:user => current_user, :trackable => @patient,:action => "Added Doctor",:message => "#{current_user.name} added #{@doctor.user.name} as #{@patient.user.name}'s doctor")
              flash[:notice] ="added doctor to #{@user.name}"
            end
          end
          redirect_to edit_user_path(params[:id],{settings: "AvailableDocs"})
        elsif(params[:user][:func] == "removeDoc")
          #finds the relationship with the doctor and then sets the patients status as not accepted
          @docRelationship=DocRelationship.where('doctor_id=? and patient_id=?', params[:user][:doctor_id], params[:user][:patient_id]).first
          if @docRelationship
            @docRelationship.update_attribute(:accepted, false)
          else
            @newRelationship=DocRelationship.new
            @newRelationship.doctor_id= params[:user][:doctor_id]
            @newRelationship.patient_id= params[:user][:patient_id]
            @newRelationship.accepted= false
            if @newRelationship.save
              flash[:notice] ="removed doctor"
            end
          end
          redirect_to edit_user_path(params[:id], {settings: "AvailableDocs"})
        else
          render 'edit'
        end
      #when a user updates their own login credentials
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
    #checks to ensure that some one is logged in to view the user
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
    #checks to see if the user being viewed is the correct one, i.e. they are that specific user or they are a director viewing a patient
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless (current_user?(@user) || is_admin)
      if is_director?(current_user) && is_patient?(@user)
        flash[:notice] = "You do not have permissions to modify patient permissions"
        redirect_to(root_url) 
      end
    end
    
end
