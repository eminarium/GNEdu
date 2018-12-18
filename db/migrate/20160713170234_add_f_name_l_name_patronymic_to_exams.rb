class AddFNameLNamePatronymicToExams < ActiveRecord::Migration
  def change
    add_column :exams, :fName, :string
    add_column :exams, :lName, :string
    add_column :exams, :patronymic, :string
  end
end
