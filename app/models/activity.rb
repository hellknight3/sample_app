class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  validates_presence_of  :action, :user,:trackable
end
