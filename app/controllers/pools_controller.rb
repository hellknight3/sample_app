  class PoolsController < ApplicationController
	before_action :signed_in_as_admin, only: [:new, :create, :edit]
	before_action :signed_in, only: [:index, :show]
  def index
	  	#puts all the pools that exist into pages, I know this is not functionality desired but was having trouble getting working
		@pools = Pool.paginate(page: params[:page])
		@myPools = current_user.pools.paginate(page: params[:page])
		@pools =  (@pools - @myPools).paginate(page: params[:page])
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
          @activity = Activity.create(:user => current_user,:trackable => @pool,:action => "CREATE")
		  flash[:notice] = "Pool successfully created"
		  redirect_to @pool
		else
			flash[:alert] = "Pool failed to be created"
		end
	  else
        flash[:alert] = "There was an error creating the pool, check that your information correct and try again"
		render 'new'	 
	  end
  end

  def edit
	@pool=Pool.find(params[:id])
  end
  def update

	@pool=Pool.find(params[:id])
	if @pool.update_attributes(pool_params)
		redirect_to pools_path({pools: "Personal"})
	else
		flash[:warning]="You entered bad data"
	render 'edit'
	
	end
  end
  private
  def pool_params
	params.require(:pool).permit(:name, :description, :specialization)
  end
  def signed_in_as_admin
  	if signed_in?
		unless is_admin
          flash[:alert] = "You do not have permission to create or edit pools."
          redirect_to pools_path
		end
	else
		store_location
		redirect_to signin_url, notice: "Please sign in."
	end
  end
  def signed_in
			unless signed_in?#checks if the user is currently signed in, the function is housed in the sessions helper for in depth analysis
				store_location
				redirect_to signin_url, notice: "Please sign in."
			end
		end
end
