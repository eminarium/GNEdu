class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :student, index: true
      t.string :doc_url

      t.timestamps
    end
  end
end
