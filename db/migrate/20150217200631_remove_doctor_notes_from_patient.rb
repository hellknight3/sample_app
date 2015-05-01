class RemoveDoctorNotesFromPatient < ActiveRecord::Migration
  def change
    remove_column :patients, :doctor_id, :integer
    remove_column :patients, :accepted, :boolean
  end
end
