class AdminsController < ApplicationController
	before_action :signed_in_admin, only: [:index,:edit, :update]
	before_action :correct_user, only: [:edit, :update]
	#see doctor controller for comments
	def index
		@users=User.paginate(page: params[:page])
	end
	def show
		@user = User.find(params[:id])
	end
	def new
		@user = User.new
	end
	def create
		@user = User.create(admin_params)
	end
	def edit
	end
	def update
		@user.update(admin_params)
	end
	private
		def admin_params
			params.require(:admin).permit(:name, :email, :password, :password_confirmation)
		end
		#before filters
		def signed_in_admin
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
