class RemoveTemplateFromExercises < ActiveRecord::Migration
  def change
    remove_column :exercises, :template, :boolean
  end
end
