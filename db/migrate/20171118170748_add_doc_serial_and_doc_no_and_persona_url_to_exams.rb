class AddDocSerialAndDocNoAndPersonaUrlToExams < ActiveRecord::Migration
  def change
    add_column :exams, :persona_url, :string
    add_column :exams, :doc_serial, :string
    add_column :exams, :doc_no, :string
  end
end
