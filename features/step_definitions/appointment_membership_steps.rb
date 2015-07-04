Then(/^atleast one pool should be associated with the appointment$/) do
  AppointmentMembership.where("Appointment_id=#{@trackable.id}").count.should_not eq 0 
end

