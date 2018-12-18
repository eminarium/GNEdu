class CreateAuthorsBooks < ActiveRecord::Migration
  def change
    create_table :authors_books, :id => false, :force => true do |t|
      t.references :book
      t.references :author
    end
    add_index :authors_books, :author_id
    add_index :authors_books, :book_id
  end
end