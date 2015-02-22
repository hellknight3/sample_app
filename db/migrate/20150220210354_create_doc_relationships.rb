class CreateDocRelationships < ActiveRecord::Migration
  def change
    create_table :doc_relationships do |t|
		t.column :doctor_id, :integer
		t.column :patient_id, :integer
		t.column :accepted, :boolean
		t.timestamps
    end
  end
end
