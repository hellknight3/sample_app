require 'spec_helper'

describe 'shared\_error_messages.html.erb', type: :view do
	it 'displays detrails correctly'do
		@user= create(:patient)
		assigns(:user)
		render :template => 'shared/_error_messages.html.erb'
	end
end 
