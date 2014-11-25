require 'spec_helper'

describe Pool do
	it "has a valid factory" do
		create(:pool).should be_valid
	end
	it "has a valid factory" do
		@pool = create(:pool)
		user = create(:user_has_pool)
		
	end
	
end