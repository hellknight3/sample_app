require 'spec_helper'

describe "patients/index" do
  before(:each) do
    assign(:patients, [
      stub_model(Patient),
      stub_model(Patient)
    ])
  end

  it "renders a list of patients" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
