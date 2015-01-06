class Appointment < ActiveRecord::Base

	has_many :messages, dependent: :destroy
	accepts_nested_attributes_for :messages
	#has_many :users, :through => :messages
end
