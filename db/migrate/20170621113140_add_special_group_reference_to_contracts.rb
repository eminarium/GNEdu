class AddSpecialGroupReferenceToContracts < ActiveRecord::Migration
  def change
    add_reference :contracts, :special_group, index: true
  end
end
