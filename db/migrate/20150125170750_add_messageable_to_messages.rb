class AddMessageableToMessages < ActiveRecord::Migration
  def up
	  change_table :messages do |t|
		t.references :messageable, :polymorphic => true
		
	  end
	  remove_column :messages, :appointment_id
  end
  def down
	change_table :messages do |t|
		t.remove_references :messageable, :polymorphic => true
		
	  end
	  add_column :messages, :appointment_id, :integer
  end
end
