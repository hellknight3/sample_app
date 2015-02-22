class Note < ActiveRecord::Base
	belongs_to :patient
	belongs_to :doctor
	validates :content, presence: true
end
