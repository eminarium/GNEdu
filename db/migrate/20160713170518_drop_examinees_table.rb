class DropExamineesTable < ActiveRecord::Migration
  def up
    drop_table :examinees
  end

  def down
    faise ActiveRecord::IrreversibleMigration
  end
end
