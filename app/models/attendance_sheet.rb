class AttendanceSheet < ActiveRecord::Base
  belongs_to :group

  has_many :attendances
  #has_many :contracts, :through => :attendances

  accepts_nested_attributes_for :attendances
end
