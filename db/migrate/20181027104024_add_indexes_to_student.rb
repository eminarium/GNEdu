class AddIndexesToStudent < ActiveRecord::Migration
  def change
    add_index :students, :fName
    add_index :students, :lName
  end
end
