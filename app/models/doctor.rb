class Doctor < ActiveRecord::Base
	has_one :user, as: :profile, dependent: :destroy
	#attr_accessible :name, :email, :password, :password_confirmation
	has_many :appointments
	has_many :pools, as: :poolable
	has_many :patients
end
