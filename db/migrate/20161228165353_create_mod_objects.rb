class CreateModObjects < ActiveRecord::Migration
  def change
    create_table :mod_objects do |t|
      t.string :modObjectName
      t.text :description
    end
  end
end
