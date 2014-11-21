require 'spec_helper'

describe 'patients\new.html.erb', type: :view do
	it 'displays detrails correctly'do
		
		@user= create(:patient)
		assigns(:user)
		puts @user.user.name
		render :template => 'patients/new.html.erb'
	end
end 
