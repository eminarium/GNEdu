class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :subjectBaseName
      t.string :subjectFullName
      t.string :subjectShortName
      t.integer :subjectLevel
      t.float :subjectPrice
      t.float :minPassingPoints
      t.text :notes

      t.timestamps
    end
  end
end
