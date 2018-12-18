class RenameColumnsInStudent < ActiveRecord::Migration
  def change
    rename_column :students, :schoolCity_id, :school_city_id
    rename_column :students, :specialSchool_id, :special_school_id
    rename_column :students, :highSchool_id, :high_school_id
  end
end
