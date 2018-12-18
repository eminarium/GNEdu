class RenamePaymentTypeIdToPaymentTypeIdInContract < ActiveRecord::Migration
  def change
    rename_column :contracts, :paymentType_id, :payment_type_id
  end
end
