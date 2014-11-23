class AddPatientRefToAppointments < ActiveRecord::Migration
  def change
    add_reference :appointments, :patient, index: true
  end
end
