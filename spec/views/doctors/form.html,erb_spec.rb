require 'spec_helper'

describe 'doctors\_form.html.erb', type: :view do
	it 'displays detrails correctly'do
		
		@user= create(:patient)
		assigns(:user)
		puts @user.user.name
		render :template => 'doctors/_form.html.erb'
	end
end 
