class RemoveHigherSchoolGradeFromStudent < ActiveRecord::Migration
  def change
    remove_column :students, :higherSchoolGrade, :string
  end
end
