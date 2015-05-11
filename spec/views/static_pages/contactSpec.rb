require 'spec_helper'

describe 'static_pages\contact.html.erb', type: :view do
	it 'displays detrails correctly'do
		@user= create(:patient)
		assigns(:user)
		render :template => 'static_pages/contact.html.erb'
	end
end 
