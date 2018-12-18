class AddOtherContractNoToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :otherContractNo, :string
  end
end
