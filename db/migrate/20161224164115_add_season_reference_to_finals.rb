class AddSeasonReferenceToFinals < ActiveRecord::Migration
  def change
    add_reference :finals, :season, index: true
  end
end
