class AddSeasonReferenceToRole < ActiveRecord::Migration
  def change
    add_reference :roles, :season, index: true
  end
end
