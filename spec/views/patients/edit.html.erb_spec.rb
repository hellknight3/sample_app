require 'spec_helper'

describe "patients/edit" do
  before(:each) do
    @patient = assign(:patient, stub_model(Patient))
  end

  it "renders the edit patient form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", patient_path(@patient), "post" do
    end
  end
end
