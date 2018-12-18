class CreateLessonTimes < ActiveRecord::Migration
  def change
    create_table :lesson_times do |t|
      t.string :lessonTimeTitle
      t.time :lessonTimeFrom
      t.time :lessonTimeTo
      t.text :notes

      t.timestamps
    end
  end
end
