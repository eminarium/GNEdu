class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :user, index: true
      t.string :noteSubject
      t.text :noteContent
    end
  end
end
