class RemoveHigherSchoolNameFromStudent < ActiveRecord::Migration
  def change
    remove_column :students, :higherSchoolName, :string
  end
end
