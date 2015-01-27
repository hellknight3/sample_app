class Patient < ActiveRecord::Base
	has_one :user, as: :profile, dependent: :destroy
	accepts_nested_attributes_for :user
	belongs_to :doctor
	#validates :emergencyContact, presence: true
<<<<<<< HEAD
+	#validates :emergencyPhoneNumber, presence: true
+	#validates :dateOfBirth, presence: true
+	#validates :familyDoctor, presence: true
+	#validates :healthCardNumber, presence: true
+	#validates :phoneNumber, presence: true
+	#validates :weight, presence: true
+	#validates :height, presence: true
+	#validates :currentMedication, presence: true
+	#validates :currentIssue, presence: true
=======
	#validates :emergencyPhoneNumber, presence: true
	#validates :dateOfBirth, presence: true
	#validates :familyDoctor, presence: true
	#validates :healthCardNumber, presence: true
	#validates :phoneNumber, presence: true
	#validates :weight, presence: true
	#validates :height, presence: true
	#validates :currentMedication, presence: true
	#validates :currentIssue, presence: true
>>>>>>> aff42573c4ea10c48954d8e34c29e70d42a1c80f
end
