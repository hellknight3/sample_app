describe Doctor do
	#create the doctor object without firstLogin variable
	before { @doctor = Doctor.new(name: "Example doctor", email: "doctor@example.com", 
				 password: "foobar", password_confirmation: "foobar"
				 #,isFirstLogin:false
				 )}
	subject{ doctor}
#test attributes specific to doctor
	
#test polymorphic attributes
	#check that the doctor object responds to all of the variables
	it { should respond_to(:name)}
	it { should respond_to(:email)}
	it { should respond_to(:password_digest)}
	it {should respond_to(:password)}
	it {should respond_to(:hasInstitution)}
	#it {should respond_to(:isFirstLogin)}
	it { should respond_to(:password_confirmation)}
	it { should respond_to(:remember_token)}
	it { should respond_to(:authenticate)}
	it {should be_valid}
	it {should respond_to(:authenticate)}

	#check if variable not present the Doctor object is invalid
	describe "when name is not present" do
		before { @doctor.name = " "}
		it {should_not be_valid}

	end
	describe "when email is not present" do
		before { @doctor.email= " " }
		it {should_not be_valid}

	end
	describe "when name is to long" do
		before { @doctor.name = "a" *51}
		it {should_not be_valid}
		
	end
	describe "when institution is not present" do
		before { @doctor.hasInstitution = " "}
		it {should_not be_valid}
		
	end
	#describe "when isFirstLogin is not present" do
#		before { @doctor.isFirstLogin = " "}
#		it {should_not be_valid}
		
#	end
	#check email must be valid
	describe "when email format is invalid" do
		it "should be invalid" do
			#create an array of invalid emails
			addresses= %w[doctor@foo,com doctor_at_foo.org example.doctor@foo. 
			foo@bar_baz.com foo@bar+baz.com]

			#for each invalid email check that the object is not valid
			addresses.each do |invalid_address|

				@doctor.email = invalid_address
				expect(@doctor).not_to be_valid
			end
		end
	end
	#check that if email is valid the user is created
	describe "when email format is valid" do
		it "should be valid" do
			#create array of valid emails
			addresses = %w[doctor@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			#check array of valid email are all valid
			addresses.each do |valid_address|
				@doctor.email = valid_address
				expect(@doctor).to be_valid
			end

		end
	end
	#check that there is no identical doctor with the same email
	describe "when email address is already taken" do
		before do
			#create doctor with the same email
			doctor_with_same_email = @doctor.dup
			#put email to upper case
			doctor_with_same_email.email = @doctor.email.upcase
			#save changes
			doctor_with_same_email.save
		end
		it{should_not be_valid}
	end
	#check if the password is missing
	describe "when password is not present" do
		#check if password is left empty that the doctor object is not valid
		before do

			@doctor = doctor.new(name: "Example doctor", email: "doctor@example.com",
					 password: " ", password_confirmation: " ")
		end
		it { should_not be_valid}
	end
	#check login fail
	describe "when password does not match confirmation" do
		before { @doctor.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end
	#check pw with 5 characters and less fails
	describe "with a password that is to short" do
		before {@doctor.password = @doctor.password_confirmation = "a" * 5 }
		it {should be_invalid}
	end
	#wtf comments plz
	describe "return value of the authenticate method" do
		before {@doctor.save}
		let(:found_doctor){doctor.find_by(email: @doctor.email)}
		describe "with valid password" do
			it{should eq found_doctor.authenticate(@doctor.password)}
		end
		describe "with invalid password" do
			let(:doctor_for_invalid_password){found_doctor.authenticate("invalid")}
			it{should_not eq doctor_for_invalid_password}
			specify { expect(doctor_for_invalid_password).to be_false}
		end

	end

	describe "remember token" do
		before{@doctor.save}
		its(:remember_token){ should_not be_blank}
	end
end
