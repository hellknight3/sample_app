require 'spec_helper'

describe User do
	it "has a valid factory" do
		create(:patient).should be_valid
	end
	it "it is invalid without a name" do 
		build(:patient, name: nil).should_not be_valid
	end 
	it "it is invalid without a email" do
		build(:patient, email: nil).should_not be_valid
	end
	it "it is invalid without a pw" do
		build(:patient, password: nil).should_not be_valid
	end
	it "it is invalid without a pwConf" do
		build(:patient, password_confirmation: nil).should_not be_valid
	end
	
	it "when email format is invalid" do
		build(:patient, email: "user@foo,com").should_not be_valid
		build(:patient, email: "user_at_foo.org").should_not be_valid
		build(:patient, email: "example.user@foo.").should_not be_valid
	end
	
	it "when email format is valid" do
		build(:patient, email: "user@foo.COM").should be_valid
		build(:patient, email: "A_US-ER@f.b.org").should be_valid
		build(:patient, email: "frst.lst@foo.jp").should be_valid
		build(:patient, email: "a+b@baz.cn").should be_valid
	
	end

	it "when email address is already taken" do
		create(:patient, email: "foo@gmail.com")
		build(:patient, email: "foo@gmail.com").should_not be_valid
	end
	
	it "when password is not present" do
		build(:patient, password: " ", password_confirmation: " ").should_not be_valid
	end
	
	it "when password does not match confirmation" do
		build(:patient, password:"foobar", password_confirmation: "barfoo").should_not be_valid
	end
	
	
	it "with a password that is to short" do
		build(:patient, password: "foo00", password_confirmation: "foo00").should_not be_valid
	end
	it "with a password that is not to short" do
		build(:patient, password: "foo000", password_confirmation: "foo000").should be_valid
	end
	
	describe"return value of the authenticate method" do
#@testUser = create(:patient, email:"foo@gmail.com")
		
	#	let(:found_user){User.find_by(email: "foo@gmail.com")}
		it "with valid password" do
			testUser = create(:patient, password: "foobar",password_confirmation:"foobar")
			testUser.authenticate("foobar").should be_true
		end
		it "with valid password" do
			testUser = create(:patient, password: "foobar",password_confirmation:"foobar")
			testUser.authenticate("notfoobar").should_not be_true
		end
		
	end
	
	it "remember token" do
		testUser = create(:patient)
		testUser.remember_token{should_not be_blank}
		
	end
	
end