class Patient < ActiveRecord::Base
	has_one :user, as: :profile, dependent: :destroy
	has_many :appointments
end
