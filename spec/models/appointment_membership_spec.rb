require 'spec_helper'

describe AppointmentMembership do
  it {should belong_to(:pool)}
  it {should belong_to(:appointment)}
  it "should have an appointment" do
    FactoryGirl.build(:appointmentMembership,:appointment => nil).should_not be_valid
  end
  it "should have a pool" do
    FactoryGirl.build(:appointmentMembership,:pool => nil).should_not be_valid
  end
  it "should have a valid factory" do
    FactoryGirl.build(:appointmentMembership).should be_valid
  end
end
