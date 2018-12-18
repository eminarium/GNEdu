class AddModObjectTranslationToModObject < ActiveRecord::Migration
  def change
    add_column :mod_objects, :modObjectTranslation, :string
  end
end
