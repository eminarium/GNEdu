class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :roomTitle
      t.integer :roomCapacity
      t.boolean :hasProjector
      t.boolean :hasEboard
      t.text :notes

      t.timestamps
    end
  end
end
