class CreateOffDays < ActiveRecord::Migration
  def change
    create_table :off_days do |t|
      t.string :off_day_title
      t.date :off_day_date
      t.boolean :is_annual
      t.text :notes

      t.timestamps
    end
  end
end
