class Appointment < ActiveRecord::Base
	#this needs to be changed to incorporate more than one of each doctor/patient and possibly an admin 
	has_one :doctor
	has_one :patient
	
	has_many :messages, dependent: :destroy
end
