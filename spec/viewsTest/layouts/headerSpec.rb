require 'spec_helper'

describe 'layouts\_header.html.erb', type: :view do
	it 'displays detrails correctly'do
		render :template => 'layouts/_header.html.erb'
	end
end 
