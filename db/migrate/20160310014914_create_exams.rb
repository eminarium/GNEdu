class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.references :examinee, index: true
      t.references :subject, index: true
      t.datetime :examDate
      t.float :examResult
      t.text :notes

      t.timestamps
    end
  end
end
