class AddPatientInformation < ActiveRecord::Migration
  def change
	change_table :patients do |t|
		t.string :emergencyContact
		t.string :emergencyPhoneNumber
		t.date :dateOfBirth
		t.string :familyDoctor
		t.integer :healthCardNumber
		t.string :phoneNumber
		t.integer :weight
		t.integer :height
		t.string :currentMedication
		t.string :currentIssue
    end
  end
end
