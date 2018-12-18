class AddIsPublicToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :isPublic, :boolean
  end
end
