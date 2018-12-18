class ChangeIsReserveToIsClosedToGroup < ActiveRecord::Migration
  def change
    rename_column :groups, :isReserve, :isClosed
  end
end
