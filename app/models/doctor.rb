class Doctor < ActiveRecord::Base
	has_one :user, as: :profile, dependent: :destroy
	accepts_nested_attributes_for :user
	#attr_accessible :name, :email, :password, :password_confirmation
	has_many :patients
	
end
