class QuestionsController < ApplicationController
  def new
	@user=current_user
	@question = Question.new
  end
  def create
	@question = Question.new(question_params)	
	if @question.save
		@question.update_attribute(:exercise_id, params[:question][:exercise_id])
		flash["success"] = "successfully added question"
		#redirects the user to the exercise that the question was added to.
		redirect_to exercise_path(params[:question][:exercise_id])
	else
		#a problem occured adding the question so will rerender the new page for the user to try again
		render 'new'
	end
  end

  def edit
	@question=Question.find(params[:id])
  end

  def index
	#finds all the questions with the current exercise id
	@questions=Question.find(:all, :conditions =>["exercise_id = :doc",{:doc => params[:exercise_id]}])	
  end
  def show
	@questions=Question.find(:all, :conditions =>["exercise_id = :doc",{:doc => params[:exercise_id]}])
  end
  private
  def question_params
  #specifies that the question can have a description and an exercise id sent to the server
	params.require(:question).permit( :description, :exercise_id)
  end
end
