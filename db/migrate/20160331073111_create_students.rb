class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.references :nationality, index: true
      t.string :fName
      t.string :lName
      t.string :patronymic
      t.boolean :gender
      t.date :birthDate
      t.string :smsMobilePhone
      t.boolean :isPupil
      t.boolean :isStudent
      t.boolean :isWorker
      t.string :faFName
      t.string :faLName
      t.string :faWorkPlace
      t.string :faOccupation
      t.string :faOfficePhone
      t.string :faMobilePhone
      t.string :maFName
      t.string :maLName
      t.string :maWorkPlace
      t.string :maOccupation
      t.string :maOfficePhone
      t.string :maMobilePhone
      t.string :workPlace
      t.string :occupation
      t.string :officePhone
      t.string :mobilePhone
      t.string :higherSchoolName
      t.integer :higherSchoolGrade
      t.integer :schoolNo
      t.string :schoolName
      t.integer :schoolGrade
      t.text :notes

      t.timestamps
    end
  end
end
