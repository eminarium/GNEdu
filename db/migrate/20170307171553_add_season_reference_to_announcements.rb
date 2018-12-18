class AddSeasonReferenceToAnnouncements < ActiveRecord::Migration
  def change
    add_reference :announcements, :season, index: true
  end
end
