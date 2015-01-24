class CreateExerciseSettings < ActiveRecord::Migration
  def change
    create_table :exercise_settings do |t|
      t.integer :exercise_id
      t.integer :pool_id
      t.boolean :template

      t.timestamps
    end
  end
end
