class CreateBookLanguages < ActiveRecord::Migration
  def change
    create_table :book_languages do |t|
      t.string :bookLanguageFullName
      t.string :bookLanguageShortName
      t.text :notes

      t.timestamps
    end
  end
end
