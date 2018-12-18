class RemoveIdFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :id, :integer
  end
end
