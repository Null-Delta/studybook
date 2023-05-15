class CreateScores < ActiveRecord::Migration[7.0]
  def change
    create_table :scores do |t|
      t.integer :lab
      t.integer :student
      t.string :score
      t.date :date
      t.text :comment
      t.text :justification

      t.timestamps
    end
  end
end
