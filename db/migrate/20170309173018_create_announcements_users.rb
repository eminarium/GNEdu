class CreateAnnouncementsUsers < ActiveRecord::Migration
  def change
    create_table :announcements_users, :id => false, :force => true do |t|
      t.references :announcement
      t.references :user

      t.timestamps
    end
    add_index :announcements_users, :user_id
    add_index :announcements_users, :announcement_id
  end
end
