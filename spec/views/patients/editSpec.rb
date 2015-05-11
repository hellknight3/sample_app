require 'spec_helper'

describe 'patients\show.html.erb', type: :view do
	it 'displays detrails correctly'do
		@user= create(:patient)
		render :template => 'patients/show.html.erb'
	end
end 
