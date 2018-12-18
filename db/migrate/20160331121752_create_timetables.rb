class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.references :group, index: true
      t.references :room, index: true
      t.integer :weekday
      t.text :notes

      t.timestamps
    end
  end
end
