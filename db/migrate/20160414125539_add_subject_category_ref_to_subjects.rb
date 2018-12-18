class AddSubjectCategoryRefToSubjects < ActiveRecord::Migration
  def change
    add_reference :subjects, :subjectCategory, index: true
  end
end
