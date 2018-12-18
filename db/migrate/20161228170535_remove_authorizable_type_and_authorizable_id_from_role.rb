class RemoveAuthorizableTypeAndAuthorizableIdFromRole < ActiveRecord::Migration
  def change
    remove_column :roles, :authorizable_type, :string
    remove_column :roles, :authorizable_id, :integer
  end
end
