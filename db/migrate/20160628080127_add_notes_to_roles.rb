class AddNotesToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :notes, :text
  end
end
