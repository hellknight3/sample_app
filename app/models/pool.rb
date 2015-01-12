class Pool < ActiveRecord::Base
	has_many :permissions
	accepts_nested_attributes_for :permissions
	has_many :users, :through => :permissions
	accepts_nested_attributes_for :users
	belongs_to :institution
end
