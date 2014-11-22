require 'spec_helper'

describe 'layouts\_footer.html.erb', type: :view do
	it 'displays detrails correctly'do
		render :template => 'layouts/_footer.html.erb'
		
		#test link to the about page
		#test link to the contact page
		#test link news
	end
#	before(:each) do
#		visit root_path
#	end
#describe "Layouts" do
#describe "GET /layouts"	do
#	it "shoud have about link" do
#		visit '/layouts/_footer'
#		click_link 'About'
#		current_path.should eq(about_path)
#	end
#end 
end