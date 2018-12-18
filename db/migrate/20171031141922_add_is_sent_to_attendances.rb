class AddIsSentToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :is_sent, :boolean
  end
end
