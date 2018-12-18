class CreateBookLends < ActiveRecord::Migration
  def change
    create_table :book_lends do |t|
      t.references :book, index: true
      t.references :student, index: true
      t.datetime :lendDateTime
      t.boolean :isReturned
      t.datetime :returnDateTime
      t.boolean :isDamaged
      t.text :notes

      t.timestamps
    end
  end
end
