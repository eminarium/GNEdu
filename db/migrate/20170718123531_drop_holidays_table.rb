class DropHolidaysTable < ActiveRecord::Migration
  def change
    drop_table :holidays
  end
end
