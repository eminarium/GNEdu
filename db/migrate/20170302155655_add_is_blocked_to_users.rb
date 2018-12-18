class AddIsBlockedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :isBlocked, :boolean
  end
end