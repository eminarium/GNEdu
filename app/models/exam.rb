class Exam < ActiveRecord::Base
  belongs_to :subject
  belongs_to :season

  validates_presence_of :fName, :message => "Ady hökman girizilmeli ..."
  validates_presence_of :lName, :message => "Familiýasy hökman girizilmeli ..."
  validates_presence_of :subject_id, :message => "Dersi hökman saýlanmaly ..."
  validates_presence_of :examResult, :message => "Synag netijesi hökman girizilmeli ..."
  validates_presence_of :examDate, :message => "Synag senesi hökman saýlanmaly ..."

end
