class AddSubjectCodeToSubjectCategory < ActiveRecord::Migration
  def change
    add_column :subject_categories, :subject_code, :string
  end
end
