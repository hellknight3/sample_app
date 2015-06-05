class Institution < ActiveRecord::Base
	has_many :pools
	validates :name, presence: true
end
