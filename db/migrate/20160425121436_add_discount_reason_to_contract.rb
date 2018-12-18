class AddDiscountReasonToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :discountReason, :text
  end
end
