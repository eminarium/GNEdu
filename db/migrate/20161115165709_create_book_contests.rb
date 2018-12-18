class CreateBookContests < ActiveRecord::Migration
  def change
    create_table :book_contests do |t|
      t.string :bookContestName
      t.references :season, index: true
      t.text :notes

      t.timestamps
    end
  end
end
