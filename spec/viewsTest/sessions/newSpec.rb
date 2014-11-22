require 'spec_helper'

describe 'sessions\new.html.erb', type: :view do
	it 'displays detrails correctly'do
		render :template => 'sessions/new.html.erb'
	end
	describe "GET /sessions" do
		it"should have content" do
			visit '/sessions/new'
		end
	end
end 
