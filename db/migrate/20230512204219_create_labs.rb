class CreateLabs < ActiveRecord::Migration[7.0]
  def change
    drop_table :labs
    create_table :labs do |t|
      t.integer :number
      t.string :name
      t.text :themes
      t.text :tasks
      t.date :date

      t.timestamps
    end
  end
end
