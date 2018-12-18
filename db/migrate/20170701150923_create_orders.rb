class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.integer :order_number
      t.text :notes

      t.timestamps
    end
  end
end
