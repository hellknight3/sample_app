class Exercise < ActiveRecord::Base
has_many :questions, dependent: :destroy
accepts_nested_attributes_for :questions, allow_destroy: true
has_many :exercise_settings
has_many :pools, :through => :exercise_settings
end
