class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.string :event_type_title
      t.string :event_type_color_code
      t.text :notes

      t.timestamps
    end
  end
end
