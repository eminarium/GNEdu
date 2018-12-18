class RenameModActionIdToModActionIdInAudit < ActiveRecord::Migration
  def change
    rename_column :audits, :modAction_id, :mod_action_id
  end
end
