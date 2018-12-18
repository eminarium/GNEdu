class RemoveExamineeIdFromExams < ActiveRecord::Migration
  def change
    remove_column :exams, :examinee_id, :integer
  end
end
