class CreateSpecialGroups < ActiveRecord::Migration
  def change
    create_table :special_groups do |t|
      t.references :season, index: true
      t.string :specialGroupTitle
      t.text :notes

      t.timestamps
    end
  end
end
