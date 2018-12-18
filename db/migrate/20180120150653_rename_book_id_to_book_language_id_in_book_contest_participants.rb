class RenameBookIdToBookLanguageIdInBookContestParticipants < ActiveRecord::Migration
  def change
    rename_column :book_contest_participants, :book_id, :book_language_id
  end
end
