class AdjustAppoitnmentsTable < ActiveRecord::Migration
  def change
  remove_column :appointments, :patient_id, :integer
remove_column :appointments, :doctor_id, :integer
  add_column :appointments, :name, :string
  end
end
