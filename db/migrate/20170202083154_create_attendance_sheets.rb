class CreateAttendanceSheets < ActiveRecord::Migration
  def change
    create_table :attendance_sheets do |t|
      t.references :group, index: true
      t.datetime :attendanceSheetDate
      t.text :attendanceSheetNotes

      t.timestamps
    end
  end
end
