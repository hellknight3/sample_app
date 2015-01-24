class AddPoolToAppointment < ActiveRecord::Migration
  def change
    add_reference :appointments, :pool, index: true
  end
end
