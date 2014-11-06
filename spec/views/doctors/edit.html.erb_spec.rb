require 'spec_helper'

describe "doctors/edit" do
  before(:each) do
    @doctor = assign(:doctor, stub_model(Doctor))
  end

  it "renders the edit doctor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", doctor_path(@doctor), "post" do
    end
  end
end
