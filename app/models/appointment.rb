class Appointment < ActiveRecord::Base

	has_many :messages, as: :messageable, dependent: :destroy	
	has_many :users, :through => :messages, :source => :messageable,
    :source_type => "User"	
	accepts_nested_attributes_for :messages
	
	belongs_to :pool
	validates :name,  presence: true
	validates :description, presence: true
end
