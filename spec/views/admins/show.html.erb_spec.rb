require 'spec_helper'

describe 'admins\edit.html.erb', type: :view do
	it 'displays detrails correctly'do
		@user= create(:patient)
		render :template => 'admins/edit.html.erb'
	end
end 
