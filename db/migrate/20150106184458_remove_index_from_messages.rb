class RemoveIndexFromMessages < ActiveRecord::Migration
  def change
  remove_index(:messages, :name => 'index_messages_on_appointment_id')
  end
end
