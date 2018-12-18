class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.references :bookLanguage, index: true
      t.string :bookName
      t.string :imageUrl
      t.integer :totalQuantity
      t.text :notes

      t.timestamps
    end
  end
end
