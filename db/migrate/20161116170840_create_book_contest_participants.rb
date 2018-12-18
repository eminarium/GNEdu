class CreateBookContestParticipants < ActiveRecord::Migration
  def change
    create_table :book_contest_participants, :id => false, :force => true do |t|
      t.references :student
      t.references :bookContest
      t.references :book
      t.text :notes

      t.timestamps
    end
    add_index :book_contest_participants, :student_id
    add_index :book_contest_participants, :bookContest_id
    add_index :book_contest_participants, :book_id
  end
end
