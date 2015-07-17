class Pool < ActiveRecord::Base
	has_many :permissions
	accepts_nested_attributes_for :permissions
	has_many :users, :through => :permissions
	accepts_nested_attributes_for :users
    has_many :institution_memberships, :as => :memberable
    has_many :institutions, :through => :institution_memberships, :source => :memberable, :source_type => "Pool"
	validates_presence_of :name,:description,:specialization #,:institution
    has_many :appointment_memberships
	has_many :appointments, :through => :appointment_memberships
	has_many :exercise_settings
	has_many :exercises, :through => :exercise_settings
end
