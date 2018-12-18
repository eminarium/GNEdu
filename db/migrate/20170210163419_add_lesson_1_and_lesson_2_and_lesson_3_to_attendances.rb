class AddLesson1AndLesson2AndLesson3ToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :lesson_1, :boolean
    add_column :attendances, :lesson_2, :boolean
    add_column :attendances, :lesson_3, :boolean
  end
end
