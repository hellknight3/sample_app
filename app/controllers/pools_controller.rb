class PoolsController < ApplicationController
	before_action :signed_in_as_admin, only: [:new, :create, :edit]
  def index
	  @pools = Pool.paginate(page: params[:page])
  end

  def show
	@pool = Pool.find(params[:id])
  end

  def new
	@user =current_user
	  @pool = Pool.new
  end

  def create
	  @pool=Pool.new(pool_params)
	  if @pool.save
		  flash[:success] = "Pool successfully created"
		  redirect_to @pool
	  else
		render 'new'	 
	  end
	
  end

  def edit
  	@users =User.paginate(page: params[:page])
	@pool=Pool.find(params[:id])
  end
  def update
	@user = User.find(params[:pool][:user_id])
	@users =User.paginate(page: params[:page])
	@pool=Pool.find(params[:id])
	if(params[:pool][:func] == "add")
		@user.update_attribute(:pool_id, params[:id])
	elsif(params[:pool][:func] == "remove")
		@user.update_attribute(:pool_id, nil)
	end
	render 'edit'
  end
  


  private
  def pool_params
	params.require(:pool).permit(:name, :institution, :description, :specialization)
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
