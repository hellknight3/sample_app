require 'spec_helper'

describe "patients/new" do
  before(:each) do
    assign(:patient, stub_model(Patient).as_new_record)
  end

  it "renders new patient form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", patients_path, "post" do
    end
  end
end
