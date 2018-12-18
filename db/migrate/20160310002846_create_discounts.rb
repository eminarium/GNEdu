class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.string :discountName
      t.integer :discountPercent
      t.text :notes

      t.timestamps
    end
  end
end
