class AddHighSchoolIdToStudent < ActiveRecord::Migration
  def change
    add_column :students, :highSchool_id, :integer
  end
end
