class RemoveHighSchoolIdFromStudent < ActiveRecord::Migration
  def change
    remove_column :students, :highSchool_id, :integer
  end
end
