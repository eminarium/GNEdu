class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :authorFName
      t.string :authorLName
      t.text :notes

      t.timestamps
    end
  end
end
