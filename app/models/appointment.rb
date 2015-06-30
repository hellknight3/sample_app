class Appointment < ActiveRecord::Base

	has_many :messages, as: :messageable, dependent: :destroy	
	has_many :users, :through => :messages, :source => :messageable,
    :source_type => "User"	
    has_many :activities, as: :trackable
	accepts_nested_attributes_for :messages
    has_many :appointment_memberships 
	has_many :pools, :through => :appointment_memberships
	validates :name,  presence: true
	validates :description, presence: true
    validates :start_time, presence: true 
    #validates :pool, presence: true
end
