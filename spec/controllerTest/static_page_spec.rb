require 'spec_helper'

describe StaticPagesController, type: :controller do
=begin
	subject{page}
	describe  "Home page" do 
		before{visit root_path}
		it{should have_selector('h1', text 'Welcome to the Sample App')}
		it{should_not have_title()}
		it{should have_selector('a', text 'Ruby on Rails Tutorial')}
		it{should have_selector('h1', text 'Welcome to the Sample App')}
	end
=end
it "should get home" do 
	get :home
    assert_response :success
	end 
it "should get help" do
	get :help
    assert_response :success
end 
it "should get about" do 
	get :about
    assert_response :success
end 
it "should get contact" do 
	get :contact
    assert_response :success
end 	
end 
