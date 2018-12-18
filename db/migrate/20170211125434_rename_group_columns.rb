class RenameGroupColumns < ActiveRecord::Migration
  def change
    rename_column :groups, :lessonTime_id, :lesson_time_id
    rename_column :groups, :groupGender_id, :group_gender_id
    rename_column :groups, :groupLanguage_id, :group_language_id
  end
end
