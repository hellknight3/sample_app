require 'spec_helper'

describe PoolsController, type: controller do
	before(:each) do 
		@admin = FactoryGirl.create(:userAdmin)
		controller.current_user = @admin 
		@pool = FactoryGirl.create(:pool)
	end	
	
	#show a new pool
#	it "should be able to create a new pool" do 
#		get :show
#	end

	#new
	
	#create
	
end
