require 'spec_helper'

describe 'sessions\new.html.erb', type: :view do
	it 'displays detrails correctly'do
		render :template => 'sessions/new.html.erb'
	end
end 
