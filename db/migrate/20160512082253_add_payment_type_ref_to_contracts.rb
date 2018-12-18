class AddPaymentTypeRefToContracts < ActiveRecord::Migration
  def change
    add_reference :contracts, :paymentType, index: true
  end
end
