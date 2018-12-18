class CreatePaymentTypes < ActiveRecord::Migration
  def change
    create_table :payment_types do |t|
      t.string :paymentTypeName
      t.text :notes

      t.timestamps
    end
  end
end
