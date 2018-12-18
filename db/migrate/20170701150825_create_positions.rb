class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.references :user, index: true
      t.integer :position_number
      t.text :notes

      t.timestamps
    end
  end
end
