class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :message
      t.references :appointment, index: true
      t.timestamps
    end
  end
end
