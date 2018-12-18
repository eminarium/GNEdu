class AddSeasonNoToSeasons < ActiveRecord::Migration
  def change
    add_column :seasons, :seasonNo, :integer
  end
end
