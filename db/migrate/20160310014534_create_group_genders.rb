class CreateGroupGenders < ActiveRecord::Migration
  def change
    create_table :group_genders do |t|
      t.string :groupGenderFullName
      t.string :groupGenderShortName
      t.text :notes

      t.timestamps
    end
  end
end
