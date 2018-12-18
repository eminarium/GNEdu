class AddHighSpecialSchoolYearToStudent < ActiveRecord::Migration
  def change
    add_column :students, :highSpecialSchoolYear, :integer
  end
end
