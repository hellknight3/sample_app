require 'spec_helper'

describe 'doctors\show.html.erb', type: :view do
	it 'displays detrails correctly'do
		@user= create(:patient)
		render :template => 'doctors/show.html.erb'
	end
end 
