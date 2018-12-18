json.array!(@students) do |student|
  json.extract! student, :id, :nationality_id, :fName, :lName, :patronymic, :gender, :birthDate, :smsMobilePhone, :isPupil, :isStudent, :isWorker, :faFName, :faLName, :faWorkPlace, :faOccupation, :faOfficePhone, :faMobilePhone, :maFName, :maLName, :maWorkPlace, :maOccupation, :maOfficePhone, :maMobilePhone, :workPlace, :occupation, :officePhone, :mobilePhone, :higherSchoolName, :higherSchoolGrade, :schoolNo, :schoolName, :schoolGrade, :notes
  json.url student_url(student, format: :json)
end
