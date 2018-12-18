class RenameSubjectCategoryIdInSubjects < ActiveRecord::Migration
  def change
    rename_column :subjects, :subjectCategory_id, :subject_category_id
  end
end
