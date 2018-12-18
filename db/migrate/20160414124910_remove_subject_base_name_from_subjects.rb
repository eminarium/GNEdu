class RemoveSubjectBaseNameFromSubjects < ActiveRecord::Migration
  def change
    remove_column :subjects, :subjectBaseName, :string
  end
end
