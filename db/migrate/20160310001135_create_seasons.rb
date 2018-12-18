class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :seasonTitle
      t.datetime :seasonFromDate
      t.datetime :seasonToDate
      t.text :notes

      t.timestamps
    end
  end
end
