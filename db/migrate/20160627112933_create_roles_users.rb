class CreateRolesUsers < ActiveRecord::Migration
  def change
    create_table :roles_users, :id => false, :force => true do |t|
      t.references  :user
      t.references  :role
    end
    add_index :roles_users, :user_id
    add_index :roles_users, :role_id
  end
end
