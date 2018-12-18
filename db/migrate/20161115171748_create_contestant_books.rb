class CreateContestantBooks < ActiveRecord::Migration
  def change
    create_table :contestant_books, :id => false, :force => true do |t|
      t.references :book
      t.references :bookContest
      t.text :notes

      t.timestamps
    end
    add_index :contestant_books, :book_id
    add_index :contestant_books, :bookContest_id
  end
end