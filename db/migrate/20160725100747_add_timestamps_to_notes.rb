class AddTimestampsToNotes < ActiveRecord::Migration
  def change
    change_table :notes do |t|
        t.timestamps
    end
  end
end
