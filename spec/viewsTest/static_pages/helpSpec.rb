require 'spec_helper'

describe 'static_pages\help.html.erb', type: :view do
	it 'displays detrails correctly'do
		@user= create(:patient)
		assigns(:user)
		render :template => 'static_pages/help.html.erb'
	end
end 
