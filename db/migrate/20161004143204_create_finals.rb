class CreateFinals < ActiveRecord::Migration
  def change
    create_table :finals, :id => false, :force => true do |t|
      t.references :contract, index: true
      t.float :finalPoints
      t.text :finalNotes

      t.timestamps
    end
  end
end
