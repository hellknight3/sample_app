class DoctorsController < ApplicationController

	before_action :signed_in_doctor, only: [:edit, :update]
	before_action :correct_user, only: [:edit, :update]
	def index
		#will need to figure out how to restrict the information
		#this will make it so a list of users is created and displayed similar to how facebook displays users
		#paginate restricts the amount that is returned in the result, i believe the default is 30 rows/users
		#this also would not function since i have removed it in the before filter.
		@users=User.paginate(page: params[:page])
	end
	def show
		#looks up the user that has the id in the params hash
		@user = User.find(params[:id])
	end
	def create
		#this should call the create function from the user controller, i don't know if i have to do anything special to make it work though. can't get fully functional implementation until the Views are set up.
		@user = User.create
	end
	def edit
		@user.edit
	end
	def update
		@user.update
	end
	private
		#before filters
		def signed_in_doctor
			unless signed_in?
				store_location
				redirect_to signin_url, notice: "Please sign in."
			end
		end
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end

end