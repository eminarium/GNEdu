class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :teacherFName
      t.string :teacherLName
      t.string :teacherPatronymic
      t.text :notes

      t.timestamps
    end
  end
end
