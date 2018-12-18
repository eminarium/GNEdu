class RenameAttendanceSheetIdToAttendanceSheetIdInAttendance < ActiveRecord::Migration
  def change
    rename_column :attendances, :attendanceSheet_id, :attendance_sheet_id
  end
end
