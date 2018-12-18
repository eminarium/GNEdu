class AddSchoolCityIdToStudent < ActiveRecord::Migration
  def change
    add_column :students, :schoolCity_id, :integer
  end
end
