require 'spec_helper'

describe 'layouts\_shim.html.erb', type: :view do
	it 'displays detrails correctly'do
		render :template => 'layouts/_shim.html.erb'
	end
end 
