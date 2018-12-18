class CreateAudits < ActiveRecord::Migration
  def change
    create_table :audits do |t|
      t.references :user, index: true
      t.references :modAction, index: true
      t.datetime :interactionDate

      t.timestamps
    end
  end
end
