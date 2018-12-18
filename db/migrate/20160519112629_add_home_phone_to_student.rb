class AddHomePhoneToStudent < ActiveRecord::Migration
  def change
    add_column :students, :homePhone, :string
  end
end
