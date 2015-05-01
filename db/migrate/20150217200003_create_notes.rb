class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :content
      t.integer :doctor_id
      t.integer :patient_id
      t.timestamps
    end
  end
end
