class CreateSeasonTests < ActiveRecord::Migration
  def change
    create_table :season_tests do |t|
      t.references :season, index: true
      t.string :seasonTestTitle
      t.date :seasonTestDate
      t.boolean :isFinal
      t.text :seasonTestNotes

      t.timestamps
    end
  end
end
