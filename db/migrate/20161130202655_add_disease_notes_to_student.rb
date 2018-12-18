class AddDiseaseNotesToStudent < ActiveRecord::Migration
  def change
    add_column :students, :diseaseNotes, :text
  end
end
