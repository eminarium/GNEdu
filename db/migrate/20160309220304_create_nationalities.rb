class CreateNationalities < ActiveRecord::Migration
  def change
    create_table :nationalities do |t|
      t.string :nationalityName
      t.text :notes

      t.timestamps
    end
  end
end
