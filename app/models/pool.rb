class Pool < ActiveRecord::Base
	has_many :permissions
	accepts_nested_attributes_for :permissions
	has_many :users, :through => :permissions
	accepts_nested_attributes_for :users
	belongs_to :institution
	validates :name, presence: true
	validates :description, presence: true
	validates :specialization, presence: true
	validates :institution, presence: true	
	has_many :appointments
	has_many :exercise_settings
	has_many :exercises, :through => :exercise_settings
end
