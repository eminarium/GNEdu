class AddSpecialSchoolIdToStudent < ActiveRecord::Migration
  def change
    add_column :students, :specialSchool_id, :integer
  end
end
