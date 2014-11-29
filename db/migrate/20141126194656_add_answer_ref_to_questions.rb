class AddAnswerRefToQuestions < ActiveRecord::Migration
  def change
    add_reference :answers, :question, index: true
    add_reference :answers, :user, index: true
  end
end
