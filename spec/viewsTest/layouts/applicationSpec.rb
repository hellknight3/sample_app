require 'spec_helper'

describe 'layouts\application.html.erb', type: :view do
	it 'displays detrails correctly'do
		render :template => 'layouts/application.html.erb'
	end
end 
