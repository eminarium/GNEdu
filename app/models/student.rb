class Student < ActiveRecord::Base
  belongs_to :nationality
  belongs_to :city
  belongs_to :school_city, :class_name => City
  belongs_to :high_school
  belongs_to :special_school

  has_many :documents
  has_many :contracts

  validates_presence_of :fName, :message => "'Ady' hökman girizilmeli ..."
  validates_presence_of :lName, :message => "'Familiýasy' hökman girizilmeli ..."
  validates_presence_of :nationality_id, :message => "'Milleti' hökman saýlanmaly ..."
  #validates_presence_of :gender, :message => "'Jynsy' hökman saýlanmaly ..."
  validates_presence_of :birthDate, :message => "'Doglan Senesi' hökman saýlanmaly ..."
  validates_presence_of :smsMobilePhone, :message => "'SMS Belgisi' hökman girizilmeli ..."


  #mount_uploader :imageUrl, ImageUploader
  #has_attached_file :imageUrl

  GENDER_TYPES = [ ["Zenan", 0], [ "Erkek", 1] ]
  validates_inclusion_of :gender, in: [false, true]

  #enum gender_type: [:zenan, :erkek]

  def first_and_last_name
    "#{self.lName} " " #{self.fName} " " #{self.patronymic}"
  end

  #def self.search(paramFName)
    #if (paramFName || paramLName)
      #where('fName LIKE ?', "%#{paramFName}%")
    #else
      #Contract.all
    #end
  #end

end
