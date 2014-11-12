require 'spec_helper'
describe PatientsController do 
 # This should return the minimal set of attributes required to create a valid
  # Patient. As you add validations to Patient, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PatientsController. Be sure to keep this updated too.
  let(:valid_session) { {} }
before { @patient = Patient.new(name: "Example patient", email: "patient@example.com", 
				 password: "foobar", password_confirmation: "foobar"
				 #,isFirstLogin:false
				 )}
	

describe "Get index" do 
	it "populates an array of patients" do 
		get :index, {}, valid_session
		assigns(:patients).should eq([patient])
	end
end 
describe "Get show" do
	it " assigns requested patient as @patient" do 
	get :new,{:id =>patient.to_param}
	assigns(:patient).should eq(patient)
	end
end

describe"Get new" do
	it "assigns a new patient to @patient" do
		get :new,{},valid_session
		assigns(:patient).should be_a_new(Patient)
	end
end
describe"Get create" do
	it "create a new patient and assign it to @patient" do
		
	end	
end
describe"Get edit" do
	it "assigns a new patient to @patient" do

	end
end
describe"Get update" do
	it "assigns a new patient to @patient" do

	end
end
describe"Get edit" do
	it "assigns a new patient to @patient" do

	end
end


end


