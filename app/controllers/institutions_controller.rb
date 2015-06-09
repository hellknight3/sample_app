class InstitutionsController < ApplicationController
	#only director can mofify the institution
	before_action :signed_in_as_director, only: [:edit, :update]
	#only people who are signed in and are part of the instituion can view the institution
	before_action :signed_in, only: [:index,:show]

def index
	@inst = Institution.find(params[:id])
end


def show
	#get the insitutions
        @inst = Institution.find(params[:id])
        #get pools in institutions
        @pools = @inst.pools
end

def edit
	@inst = Institution.find(params[:id])
end
def update
	@inst = Institution.find(params[:id])
	if @inst.update_attributes(institution_params)
	puts "h"	
                redirect_to institution_path(:id)	
        puts "t"
	else
                flash[:warning]="You entered bad data"
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
			redirect_to signin_url, notice: "You do not have permission to do that"
		
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
