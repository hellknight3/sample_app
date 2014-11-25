class SessionsController < ApplicationController
	def new

	end
	def create
		@user = User.find_by( email: params[:session][:email].downcase)
		if @user && @user.authenticate(params[:session][:password])
			sign_in @user
			if current_user.profile_type =="Admin"
				redirect_back_or admin_path(@user.profile_id)
			
			elsif current_user.profile_type =="Doctor"
				redirect_back_or doctor_path(@user.profile_id)
			
			elsif current_user.profile_type =="Patient"
				redirect_back_or patient_path(@user.profile_id)

			end			
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end
	
	def destroy
		sign_out
		redirect_to root_url
	end
end
