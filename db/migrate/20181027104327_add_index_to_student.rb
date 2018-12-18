class AddIndexToStudent < ActiveRecord::Migration
  def change
    add_index :students, :patronymic
  end
end
