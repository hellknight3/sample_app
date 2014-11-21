require 'spec_helper'

describe 'admins\new.html.erb', type: :view do
	it 'displays detrails correctly'do
		
		@user= create(:patient)
		assigns(:user)
		puts @user.user.name
		render :template => 'admins/new.html.erb'
	end
end 
