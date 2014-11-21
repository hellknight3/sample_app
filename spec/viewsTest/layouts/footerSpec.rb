require 'spec_helper'

describe 'layouts\_footer.html.erb', type: :view do
	it 'displays detrails correctly'do
		render :template => 'layouts/_footer.html.erb'
	end
end 
