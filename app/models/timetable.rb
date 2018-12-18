class Timetable < ActiveRecord::Base
  belongs_to :group
  belongs_to :room

end
