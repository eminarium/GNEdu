class AddRoomShortTitleToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :roomShortTitle, :string
  end
end
