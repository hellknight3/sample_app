require 'spec_helper'

describe "doctors/index" do
  before(:each) do
    assign(:doctors, [
      stub_model(Doctor),
      stub_model(Doctor)
    ])
  end

  it "renders a list of doctors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
