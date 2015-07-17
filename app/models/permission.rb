class Permission < ActiveRecord::Base
	belongs_to :user
	belongs_to :pool
	accepts_nested_attributes_for :pool
end
