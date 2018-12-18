class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :stateName
      t.text :notes

      t.timestamps
    end
  end
end
