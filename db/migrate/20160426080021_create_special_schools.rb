class CreateSpecialSchools < ActiveRecord::Migration
  def change
    create_table :special_schools do |t|
      t.string :specialSchoolName
      t.text :notes

      t.timestamps
    end
  end
end
