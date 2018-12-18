class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :seasonContractNo
      t.references :season, index: true
      t.references :group, index: true
      t.references :student, index: true
      t.references :discount, index: true
      t.datetime :registrationDate
      t.boolean :isBookGiven
      t.float :amountPaid
      t.boolean :isMoneyReturned
      t.text :notes

      t.timestamps
    end
  end
end
