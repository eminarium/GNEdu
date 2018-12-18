class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :cityName
      t.references :state, index: true
      t.text :notes

      t.timestamps
    end
  end
end
