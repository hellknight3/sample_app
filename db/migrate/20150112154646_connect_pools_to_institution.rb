class ConnectPoolsToInstitution < ActiveRecord::Migration
  def change
	add_reference :pools, :institutions, index: true
	remove_column :pools, :institution, :string
  end
end
