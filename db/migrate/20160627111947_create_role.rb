class CreateRole < ActiveRecord::Migration
  def change
    create_table :roles, :force => true do |t|
      t.string :roleName
      t.string :authorizable_type
      t.integer :authorizable_id
      t.timestamps null: false
    end

    add_index :roles, [:authorizable_type, :authorizable_id]
  end
end
