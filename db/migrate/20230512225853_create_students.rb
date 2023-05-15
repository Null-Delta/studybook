class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :firstname
      t.string :lastname
      t.string :patronymic
      t.string :phone
      t.string :telegram
      t.string :email
      t.string :git

      t.timestamps
    end
  end
end
