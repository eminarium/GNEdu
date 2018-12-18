class CreateModActions < ActiveRecord::Migration
  def change
    create_table :mod_actions do |t|
      t.references :modObject, index: true
      t.string :modActionName
      t.text :description

      t.timestamps
    end
  end
end
