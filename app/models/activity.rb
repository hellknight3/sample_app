class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  validates_presence_of :message, :action, :user,:trackable
end
