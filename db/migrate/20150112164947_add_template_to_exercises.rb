class AddTemplateToExercises < ActiveRecord::Migration
  def change
	add_column :exercises, :template, :boolean
  end
end
