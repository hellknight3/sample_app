require 'spec_helper'

describe "doctors/new" do
  before(:each) do
    assign(:doctor, stub_model(Doctor).as_new_record)
  end

  it "renders new doctor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", doctors_path, "post" do
    end
  end
end
