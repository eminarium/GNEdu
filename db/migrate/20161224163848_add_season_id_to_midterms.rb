class AddSeasonIdToMidterms < ActiveRecord::Migration
  def change
    add_reference :midterms, :season, index: true
  end
end
