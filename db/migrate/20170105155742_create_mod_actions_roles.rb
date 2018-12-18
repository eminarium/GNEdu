class CreateModActionsRoles < ActiveRecord::Migration
  def change
    create_table :mod_actions_roles, :id => false, :force => true do |t|
      t.references :role
      t.references :modAction
      t.boolean :allowAccess
      t.boolean :auditTrack

      t.timestamps
    end
    add_index :mod_actions_roles, :role_id
    add_index :mod_actions_roles, :modAction_id
  end
end