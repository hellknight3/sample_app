require 'spec_helper'

describe 'admins\index.html.erb', type: :view do
	it 'displays detrails correctly'do
		
		@user= create(:patient)
		assigns(:user)
		puts @user.user.name
		render :template => 'admins/index.html.erb'
	end
end 
