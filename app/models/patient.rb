class Patient < ActiveRecord::Base
	has_one :user, as: :profile, dependent: :destroy
	has_many :appointments
	has_one :pool, as: :poolable
	has_one :doctor
end
