require 'spec_helper'

describe 'doctors\new.html.erb', type: :view do
	it 'displays detrails correctly'do
		
		@user= create(:patient)
		assigns(:user)
		puts @user.user.name
		render :template => 'doctors/new.html.erb'
	end
end 
