class Message < ActiveRecord::Base
	belongs_to :appointment
	belongs_to :user
	validates :message, presence: true
end
