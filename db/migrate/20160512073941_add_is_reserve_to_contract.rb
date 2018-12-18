class AddIsReserveToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :isReserve, :boolean
  end
end
