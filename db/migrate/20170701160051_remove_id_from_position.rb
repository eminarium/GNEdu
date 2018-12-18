class RemoveIdFromPosition < ActiveRecord::Migration
  def change
    remove_column :positions, :id, :integer
  end
end
