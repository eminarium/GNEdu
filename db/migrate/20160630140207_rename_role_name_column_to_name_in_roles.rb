class RenameRoleNameColumnToNameInRoles < ActiveRecord::Migration
  def change
    rename_column :roles, :roleName, :name
  end
end
