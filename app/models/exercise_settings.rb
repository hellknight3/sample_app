class ExerciseSettings < ActiveRecord::Base
	belongs_to :exercise
	belongs_to :pool
end
