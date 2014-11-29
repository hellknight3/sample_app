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
		redirect_to exercise_path(params[:question][:exercise_id])
	else
		render 'new'
	end
  end

  def edit
	@question=Question.find(params[:id])
  end

  def index
	@questions=Question.find(:all, :conditions =>["exercise_id = :doc",{:doc => params[:exercise_id]}])	
  end
  def show
	@questions=Question.find(:all, :conditions =>["exercise_id = :doc",{:doc => params[:exercise_id]}])
  end
  private
  def question_params
	params.require(:question).permit( :description, :exercise_id)
  end
end
