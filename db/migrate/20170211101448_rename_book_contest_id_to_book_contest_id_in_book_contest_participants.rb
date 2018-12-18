class RenameBookContestIdToBookContestIdInBookContestParticipants < ActiveRecord::Migration
  def change
    rename_column :book_contest_participants, :bookContest_id, :book_contest_id
  end
end
