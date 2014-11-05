class CreateAdmins < ActiveRecord::Migration
  def change
    change_table :users do |t|
	    t.references :profile, :polymorphic => true
    end
    create_table :admins do |t|
	
    end
    
  end
end
