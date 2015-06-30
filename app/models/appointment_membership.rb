class AppointmentMembership < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :pool
  validates_presence_of :appointment, :pool
end
