require 'spec_helper'

describe 'patients\edit.html.erb', type: :view do
	it 'displays detrails correctly'do
		@user= create(:patient)
		render :template => 'patients/edit.html.erb'
	end
end 
