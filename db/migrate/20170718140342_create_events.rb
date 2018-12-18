class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :event_type, index: true
      t.string :event_title
      t.datetime :event_from_datetime
      t.datetime :event_to_datetime
      t.boolean :is_weekly
      t.text :notes

      t.timestamps
    end
  end
end
