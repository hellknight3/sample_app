class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions, :id => false do |t|
      t.integer :user_id
      t.integer :pool_id
    end
  end
end
