class AddPartsToUsers < ActiveRecord::Migration
  def change
	  add_column :users, :first_login, :boolean
  end
end
