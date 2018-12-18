class Room < ActiveRecord::Base
  #acts_as_authorization_object

  has_many :timetables

  validates_presence_of :roomFullTitle, :message => "'Doly Ady' hökman girizilmeli ..."
  validates_presence_of :roomShortTitle, :message => "'Gysgaça Ady' hökman girizilmeli ..."
  validates_presence_of :roomCapacity, :message => "'Ýer Sany' hökman girizilmeli ..."

end
