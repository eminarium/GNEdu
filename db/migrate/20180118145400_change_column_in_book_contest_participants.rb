class ChangeColumnInBookContestParticipants < ActiveRecord::Migration
  def change
    rename_column :book_contest_participants, :student_id, :contract_id
  end
end
