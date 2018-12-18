class AddHighSpecialSchoolOtherToStudent < ActiveRecord::Migration
  def change
    add_column :students, :highSpecialSchoolOther, :string
  end
end
