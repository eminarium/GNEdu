class Teacher < ActiveRecord::Base

  belongs_to :user
  has_many :groups

  validates_presence_of :teacherFName, :message => "Ady hökman girizilmeli ..."
  validates_presence_of :teacherLName, :message => "Familiýasy hökman girizilmeli ..."

  def full_name
    "#{self.teacherFName} " " #{self.teacherPatronymic}" " #{self.teacherLName} "
  end

end
