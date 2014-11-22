class AddAcceptedToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :accepted, :boolean
  end
end
