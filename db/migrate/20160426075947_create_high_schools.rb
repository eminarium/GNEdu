class CreateHighSchools < ActiveRecord::Migration
  def change
    create_table :high_schools do |t|
      t.string :highSchoolName
      t.text :notes

      t.timestamps
    end
  end
end
