class RemoveSpecialSchoolIdFromStudent < ActiveRecord::Migration
  def change
    remove_column :students, :specialSchool_id, :integer
  end
end
