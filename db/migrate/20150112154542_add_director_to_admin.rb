class AddDirectorToAdmin < ActiveRecord::Migration
  def change
	add_column :admins, :director, :boolean
  end
end
