require 'spec_helper'

describe 'admins\show.html.erb', type: :view do
	it 'displays detrails correctly'do
		@user= create(:patient)
		render :template => 'admins/show.html.erb'
	end
end 
