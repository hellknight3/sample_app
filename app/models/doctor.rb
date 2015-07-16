class Doctor < ActiveRecord::Base
	has_one :user, as: :profile, dependent: :destroy
	accepts_nested_attributes_for :user
	has_many :doc_relationships
	accepts_nested_attributes_for :doc_relationships
	has_many :patients, :through => :doc_relationships
    has_many :activities, :as => :trackable
	#accepts_nested_attributes_for :patients
end
