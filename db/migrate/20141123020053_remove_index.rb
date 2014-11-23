class RemoveIndex < ActiveRecord::Migration
  def change
	remove_index(:appointments, :patient_id)
	remove_index(:appointments, :doctor_id)
	
  end
end
