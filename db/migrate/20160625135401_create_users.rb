class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :userLogin
      t.string :userFName
      t.string :userLName
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.text :notes

      t.timestamps
    end
  end
end
