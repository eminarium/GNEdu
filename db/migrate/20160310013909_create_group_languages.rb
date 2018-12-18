class CreateGroupLanguages < ActiveRecord::Migration
  def change
    create_table :group_languages do |t|
      t.string :groupLanguageFullName
      t.string :groupLanguageShortName
      t.text :notes

      t.timestamps
    end
  end
end
