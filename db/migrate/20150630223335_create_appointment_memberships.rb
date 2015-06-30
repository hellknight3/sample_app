class CreateAppointmentMemberships < ActiveRecord::Migration
  def change
    create_table :appointment_memberships do |t|
      t.references :appointment, index: true
      t.references :pool, index: true

      t.timestamps
    end
  end
end
