  class PoolsController < ApplicationController
	before_action :signed_in_as_admin, only: [:new, :create, :edit]
  def index
	  
	  #if current_user.profile_type=="Doctor"
	  #@pools= Pool.find(:all, :conditions =>["doctor_id = :doc",{:doc => current_user.profile_id}])
	  #elsif current_user.profile_type=="Patient"
#		@pools= Pool.find(:all, :conditions =>["patient_id = :doc",{:doc => current_user.profile_id}])
#	  elsif current_user.profile_type=="Admin"
		#puts all the pools that exist into pages, I know this is not functionality desired but was having trouble getting working
		@pools = Pool.paginate(page: params[:page])
#	  end
end
  def show
	#finds the pool that is requested, this is stored in params hash it will look like http://....pool/{:id}
	@pool = Pool.find(params[:id])
	@users = @pool.users
  end

  def new
	#creates another variable for current_user, probably just to side step a bug, will look into later
	@user =current_user
	#brings a pool variable into scope for use with the new view
	  @pool = Pool.new
  end

  def create
	#creates a new pool variable that has the variables that the user tries to edit checked against the pool_params which specifies the allowed fields to be changed
	  @pool=Pool.new(pool_params)
	  if @pool.save
		@permission = Permission.new
		@permission.user_id =current_user.id
		@permission.pool_id = @pool.id
		if @permission.save
		  flash[:success] = "Pool successfully created"
		  redirect_to @pool
		else
			flash[:failure] = "Pool failed to be created"
		end
	  else
		render 'new'	 
	  end
  end

  def edit
	@pool=Pool.find(params[:id])
  end
  def update

	@pool=Pool.find(params[:id])
	@pool.update_attributes(pool_params)
	render 'edit'
  end
  


  private
  def pool_params
	params.require(:pool).permit(:name, :description, :specialization)
  end
  def signed_in_as_admin
  
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
end
