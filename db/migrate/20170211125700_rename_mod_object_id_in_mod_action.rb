class RenameModObjectIdInModAction < ActiveRecord::Migration
  def change
    rename_column :mod_actions, :modObject_id, :mod_object_id
  end
end
