class AddUserReferenceToTeacher < ActiveRecord::Migration
  def change
    add_reference :teachers, :user, index: true
  end
end
