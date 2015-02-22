class AddAcceptedToPermissions < ActiveRecord::Migration
  def change
    add_column :permissions, :accepted, :boolean
  end
end
