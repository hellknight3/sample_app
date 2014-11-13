require 'spec_helper'

describe User do
	it "has a valid factory" do
		create(:user).should be_valid
	end
	it "it is invalid without a name" do 
		build(:user, name: nil).should_not be_valid
	end 
	it "it is invalid without a email" do
		build(:user, email: nil).should_not be_valid
	end
	it "it is invalid without a pw" do
		build(:user, password: nil).should_not be_valid
	end
	it "it is invalid without a pwConf" do
		build(:user, password_confirmation: nil).should_not be_valid
	end
	
	it "when email format is invalid" do
		build(:user, email: "user@foo,com").should_not be_valid
		build(:user, email: "user_at_foo.org").should_not be_valid
		build(:user, email: "example.user@foo.").should_not be_valid
	end
	
	it "when email format is valid" do
		build(:user, email: "user@foo.COM").should be_valid
		build(:user, email: "A_US-ER@f.b.org").should be_valid
		build(:user, email: "frst.lst@foo.jp").should be_valid
		build(:user, email: "a+b@baz.cn").should be_valid
	
	end

	it "when email address is already taken" do
		create(:user, email: "foo@gmail.com")
		build(:user, email: "foo@gmail.com").should_not be_valid
	end
	
	it "when password is not present" do
		build(:user, password: " ", password_confirmation: " ").should_not be_valid
	end
	
	it "when password does not match confirmation" do
		build(:user, password:"foobar", password_confirmation: "barfoo").should_not be_valid
	end
	
	
	it "with a password that is to short" do
		build(:user, password: "foo00", password_confirmation: "foo00").should_not be_valid
	end
	it "with a password that is not to short" do
		build(:user, password: "foo000", password_confirmation: "foo000").should be_valid
	end
	
	describe"return value of the authenticate method" do
		let(:testUser){create(:user, email:"foo@gmail.com")}
		
		let(:found_user){User.find_by(email: "foo@gmail.com")}
		
		describe "with valid password" do
			it{should eq found_user.authenticate(testUser.password)}
		end
		let(:user_for_invalid_password){found_user.authenticate("invalid")}
		describe "with invalid password" do
			it{should_not eq user_for_invalid_password}
			specify { expect(user_for_invalid_password).to be_false}
		
		end
	end
	
	it "remember token" do
		testUser = create(:user)
		testUser.remember_token{should_not be_blank}
		
	end
	
end