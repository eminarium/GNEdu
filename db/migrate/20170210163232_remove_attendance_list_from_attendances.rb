class RemoveAttendanceListFromAttendances < ActiveRecord::Migration
  def change
    remove_column :attendances, :attendanceList, :string
  end
end
