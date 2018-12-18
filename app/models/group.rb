class Group < ActiveRecord::Base
  belongs_to :subject
  belongs_to :season
  belongs_to :lesson_time
  belongs_to :teacher
  belongs_to :group_gender
  belongs_to :group_language

  has_many :contracts
  has_many :timetables
  has_many :attendance_sheets

  validates_presence_of :subject_id, :message => "'Dersi' hökman saýlanmaly ..."
  validates_presence_of :season_id, :message => "'Tapgyry' hökman saýlanmaly ..."
  validates_presence_of :lesson_time_id, :message => "'Wagty' hökman saýlanmaly ..."
  #validates_presence_of :teacher_id, :message => "'Mugallymy' hökman saýlanmaly ..."
  validates_presence_of :group_gender_id, :message => "'Görnüşi' hökman saýlanmaly ..."
  validates_presence_of :group_language_id, :message => "'Dili' hökman saýlanmaly ..."
  validates_presence_of :groupTitle, :message => "'Belgisi' hökman girizilmeli ..."

end
