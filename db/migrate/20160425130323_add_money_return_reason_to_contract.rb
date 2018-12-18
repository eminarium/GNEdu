class AddMoneyReturnReasonToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :moneyReturnReason, :text
  end
end
