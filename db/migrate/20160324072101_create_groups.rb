class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :subject, index: true
      t.references :season, index: true
      t.references :lessonTime, index: true
      t.references :teacher, index: true
      t.references :groupGender, index: true
      t.references :groupLanguage, index: true
      t.string :groupTitle
      t.boolean :isReserve
      t.integer :groupLimit
      t.text :notes

      t.timestamps
    end
  end
end
