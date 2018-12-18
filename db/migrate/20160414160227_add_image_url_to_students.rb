class AddImageUrlToStudents < ActiveRecord::Migration
  def change
    add_column :students, :imageUrl, :string
  end
end
