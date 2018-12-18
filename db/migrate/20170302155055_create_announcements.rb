class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :announcementSubject
      t.text :announcementBody

      t.timestamps
    end
  end
end
