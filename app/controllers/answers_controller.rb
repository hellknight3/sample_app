class AnswersController < ApplicationController
	def new
	end

	def edit
	end
	def create
		#instantiates the answer variable
		@answer = Answer.new
		#checks if the answer successfully saves in the database
		if @answer.save
			@answer.update_attribute(:question_id, params[:answer][:question_id])
			@answer.update_attribute(:user_id, current_user.id)
			flash[:success]="successfully saved response"
			
			
		else
			flash[:error]="a problem occured saving your response"
		end
		redirect_to exercise_path(params[:answer][:exercise_id])

	end
	def update
		@answer = Answer.find(params[:id])	
		@answer.update_attribute(:question_id, params[:answer][:question_id])
		@answer.update_attribute(:user_id, current_user.id)
		redirect_to exercise_path(params[:answer][:exercise_id])
	end
	def index
	end
end
