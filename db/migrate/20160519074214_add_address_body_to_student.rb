class AddAddressBodyToStudent < ActiveRecord::Migration
  def change
    add_column :students, :addressBody, :text
  end
end
