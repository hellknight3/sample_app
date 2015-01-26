class DoctorsNotes < ActiveRecord::Migration
  def change
	change_table :patients do |t|
		t.string :doctorNotes
	end
  end
end
