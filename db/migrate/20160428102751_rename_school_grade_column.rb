class RenameSchoolGradeColumn < ActiveRecord::Migration
  def change
    rename_column :students, :schoolGrade, :schoolYear
  end
end
