class AddInstitutionIdToPool < ActiveRecord::Migration
  def change
  	add_column :pools, :institution_id, :integer
  end
end
