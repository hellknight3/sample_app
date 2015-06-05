class AddDescriptionToInstitution < ActiveRecord::Migration
  def change
	add_column :institutions, :description, :string
  end
end
