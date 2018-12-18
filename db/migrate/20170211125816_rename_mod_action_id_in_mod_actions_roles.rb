class RenameModActionIdInModActionsRoles < ActiveRecord::Migration
  def change
    rename_column :mod_actions_roles, :modAction_id, :mod_action_id
  end
end
