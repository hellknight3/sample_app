class Pool < ActiveRecord::Base
	has_many :permissions
	accepts_nested_attributes_for :permissions
	has_many :users, :through => :permissions
	accepts_nested_attributes_for :users
	belongs_to :institution
	accepts_nested_attributes_for :permissions
	has_many :appointments
	has_many :exercise_settings
	has_many :exercises, :through => :exercise_settings
end
