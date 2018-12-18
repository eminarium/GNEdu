class AddReturnDeadlineToSeasons < ActiveRecord::Migration
  def change
    add_column :seasons, :return_deadline, :date
  end
end
