require 'spec_helper'

describe Institution do
	it "has a valid factory" do
		create(:institution).should be_valid
	end
end
