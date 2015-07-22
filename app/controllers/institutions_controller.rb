class InstitutionsController < ApplicationController
	#only director can mofify the institution
	before_action :signed_in_as_director, only: [:new,:create,:edit, :update]
	#only people who are signed in and are part of the instituion can view the institution
	before_action :signed_in, only: [:index,:show]

def index
  if params[:institution].nil? || params[:institution] == "My"
	@institution = Institution.joins(:institution_memberships).where("institution_memberships.memberable_id = #{current_user.id} AND institution_memberships.memberable_type = 'User'").paginate(:page => params[:page])
  elsif params[:institution] == "Other"
	@institution = Institution.joins(:institution_memberships).where("institution_memberships.memberable_id = #{current_user.id} AND institution_memberships.memberable_type = 'User'").all
    @institution= Institution.joins(:institution_memberships) - @institution
    #@institution= @instituion.paginate(:page => params[:page])
  end
end

def new
  @institution = Institution.new
end
def create
  @institution=Institution.new(institution_params)
  if @institution.save
    InstitutionMembership.create(:institution => @institution,:memberable => current_user)
   Activity.create(:user => current_user,:trackable => @institution,:action => "created institution")
   flash[:notice]="Successfully created a new institution."
    redirect_to institution_path(@institution)
  else
    flash[:alert]="There was a problem creating the institution please check the information provided and try again."
    render 'new'
  end
end
def show
	#get the insitutions
        @institution = Institution.find(params[:id])
        #get pools in institutions
        @pools = @institution.pools
		@news = @institution.messages
end

def edit
	@institution = Institution.find(params[:id])
end
def update
	@institution = Institution.find(params[:id])
	if @institution.update_attributes(institution_params)

      flash[:notice]= "successfully updated the institutions information"
      Activity.create(:user => current_user,:trackable => @institution, :action => "Updated Institution")
                redirect_to  @institution
	else
                flash[:warning]=""
        render 'edit'
        end
end

private
def institution_params
	params.require(:institution).permit(:name, :description)
end


def signed_in_as_director
	if signed_in?
	
		unless is_director
			redirect_to go_to_home, alert: "You do not have permission to do that"
		
		else
		
		end
	
	else
       	        store_location
                redirect_to signin_url, notice: "Please sign in."
	end
end

def signed_in
	unless signed_in?
  	        store_location
                redirect_to signin_url, notice: "Please sign in."
	end 
end

end
