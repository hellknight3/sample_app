require 'spec_helper'
describe UserController do 
 # This should return the minimal set of attributes required to create a valid
  # Patient. As you add validations to Patient, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PatientsController. Be sure to keep this updated too.
  lets(:valid_session) { {} }
  
  
describe "Get index" do 
	it "populates an array of Users" do
		
	end
	it "renders the: index view"
end
                                
describe"Get create" do
	it "assigns the requested user to @user"
	it "renders the :show template"
end

do "Get show" do
	it "assigns a new User to @user"
	it "renders the new template"
end

do "Get new" do
	context "with valid attributes" do
		it"saves the new user in the database"
		it"redirects to the home page"
	end
	context "with invalid attributes" do
		it "does not save the new contact in the database"
		it "re-renders :new template"
	end
end		
do "Get Edit" do
end
do "Get Update" do
end


end