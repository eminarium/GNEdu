class AddNotesToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :notes, :text
  end
end
