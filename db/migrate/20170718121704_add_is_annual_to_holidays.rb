class AddIsAnnualToHolidays < ActiveRecord::Migration
  def change
    add_column :holidays, :is_annual, :boolean
  end
end
