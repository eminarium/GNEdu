class ChangeRoomTitleToRoomFullTitleToRoom < ActiveRecord::Migration
  def change
    rename_column :rooms, :roomTitle, :roomFullTitle
  end
end
