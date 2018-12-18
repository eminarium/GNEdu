class AddObjIdToAudits < ActiveRecord::Migration
  def change
    add_column :audits, :obj_id, :integer
  end
end
