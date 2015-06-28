class Message < ActiveRecord::Base
	belongs_to :messageable, polymorphic: true
	belongs_to :user
	validates :message, :presence => true
    validates :user, :presence => true
    validates :messageable, :presence => true
end
