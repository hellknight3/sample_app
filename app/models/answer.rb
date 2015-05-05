class Answer < ActiveRecord::Base
	#creates an answer to correlate with the question
	belongs_to :question
	#will add a user id to the answer
	has_one :user
	validates :response, presence: true
end
	
