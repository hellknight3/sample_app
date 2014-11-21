require 'spec_helper'

describe 'patients\_form.html.erb', type: :view do
	it 'displays detrails correctly'do
		
		@user= create(:patient)
		assigns(:user)
		puts @user.user.name
		render :template => 'patients/_form.html.erb'
	end
end 
