class Appointment < ActiveRecord::Base
	has_one :doctor
	has_one :patient
	has_many :messages, dependent: :destroy
end
