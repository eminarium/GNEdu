class Subject < ActiveRecord::Base
  belongs_to :subject_category

  validates_presence_of :subject_category_id, :message => "'Kategoriýasy' hökman saýlanmaly ..."
  validates_presence_of :subjectFullName, :message => "'Doly Ady' hökman girizilmeli ..."
  validates_presence_of :subjectShortName, :message => "'Gysgaça Ady' hökman girizilmeli ..."
  validates_presence_of :subjectLevel, :message => "'Derejesi' hökman girizilmeli ..."
  validates_presence_of :subjectPrice, :message => "'Bahasy' girizilmeli ..."
  validates_presence_of :minPassingPoints, :message => "'Geçme Baly' hökman girizilmeli ..."

end
