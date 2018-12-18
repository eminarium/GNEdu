class CreateNotesUsers < ActiveRecord::Migration
  def change
    create_table :notes_users, :id => false, :force => true do |t|
      t.references :note
      t.references :user
    end
    add_index :notes_users, :user_id
    add_index :notes_users, :note_id
  end
end
