class Attendance < ActiveRecord::Base
  self.primary_keys = :contract_id, :attendance_sheet_id

  belongs_to :contract
  #belongs_to :attendance_sheet
  belongs_to :attendance_sheet

end
