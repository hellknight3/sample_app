require 'spec_helper'

describe "patients/show",  type: :view do


  before(:each) do
    @patient = create(:patient)
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end

end