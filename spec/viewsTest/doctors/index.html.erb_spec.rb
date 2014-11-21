require 'spec_helper'

describe 'doctors\index.html.erb', type: :view do
	it 'displays detrails correctly'do
		
		@user= create(:patient)
		assigns(:user)
		puts @user.user.name
		render :template => 'doctors/index.html.erb'
	end
end 
