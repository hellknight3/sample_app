class Patient < ActiveRecord::Base
	has_one :user, as: :profile, dependent: :destroy
	accepts_nested_attributes_for :user
	has_many :doc_relationships
	has_many :doctors, :through => :doc_relationships
	#validates :emergencyContact, presence: true

	#validates :emergencyPhoneNumber, presence: true
	#validates :dateOfBirth, presence: true
	#validates :familyDoctor, presence: true
	#validates :healthCardNumber, presence: true
	#validates :phoneNumber, presence: true
	#validates :weight, presence: true
	#validates :height, presence: true
	#validates :currentMedication, presence: true
	#validates :currentIssue, presence: true
end
