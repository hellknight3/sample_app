class ExercisesController < ApplicationController
  def new
	@user =current_user
	@exercise=Exercise.new
  end
  def create
	@exercise=Exercise.new(exercise_params)
	if @exercise.save
		flash[:success]="successfully created exercise"
		redirect_to new_question_path({exercise_id: @exercise.id})
	else
		render 'new'
	end
end

  def edit
	@exercise=Exercise.find(params[:id])
  end

  def index
	@exercises=Exercise.all
	
  end
  def show
  @exercise=Exercise.find(params[:id])
  @questions=@exercise.questions
	#@questions=Question.find(:all, :conditions =>["exercise_id = :doc",{:doc => params[:id]}])
  end
  def destroy
	Exercise.find(params[:id]).destroy
			flash[:success]="Destroyed exercise"
			redirect_to exercises_path
  end
	def update
		@exercise = Exercise.find(params[:id])
		if @exercise.update_attributes(exercise_params)
			redirect_to @exercise, notice: "Successfully updated exercise."
		else
			render :edit
		end
	end
  private
  def exercise_params
	params.require(:exercise).permit(:name, :description, questions_attributes: [:id, :description, :_destroy])
  end
  
end
