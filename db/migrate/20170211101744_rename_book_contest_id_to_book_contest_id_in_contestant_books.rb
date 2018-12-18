class RenameBookContestIdToBookContestIdInContestantBooks < ActiveRecord::Migration
  def change
    rename_column :contestant_books, :bookContest_id, :book_contest_id
  end
end
