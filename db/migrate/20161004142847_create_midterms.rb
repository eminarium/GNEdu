class CreateMidterms < ActiveRecord::Migration
  def change
    create_table :midterms, :id => false, :force => true do |t|
      t.references :contract
      t.integer :midtermOrderNo
      t.float :midtermPoints
      t.boolean :isReleasedFrom
      t.text :midtermNotes

      t.timestamps
    end
    add_index :midterms, :contract_id
    add_index :midterms, :midtermOrderNo
  end
end
