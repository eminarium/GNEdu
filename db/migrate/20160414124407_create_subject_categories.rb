class CreateSubjectCategories < ActiveRecord::Migration
  def change
    create_table :subject_categories do |t|
      t.string :subjectCategoryFullName
      t.string :subjectCategoryShortName
      t.text :notes

      t.timestamps
    end
  end
end
