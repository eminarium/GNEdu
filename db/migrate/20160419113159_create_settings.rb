class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :settingName
      t.string :settingValue
      t.text :notes

      t.timestamps
    end
  end
end
