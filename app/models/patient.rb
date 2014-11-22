class Patient < ActiveRecord::Base
	has_one :user, as: :profile, dependent: :destroy
	accepts_nested_attributes_for :user
	has_many :appointments
	belongs_to :doctor
end
