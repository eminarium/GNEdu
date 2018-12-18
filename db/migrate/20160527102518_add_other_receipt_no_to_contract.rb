class AddOtherReceiptNoToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :otherReceiptNo, :string
  end
end
