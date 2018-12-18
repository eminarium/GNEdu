class AddSpecialSchoolRefToStudent < ActiveRecord::Migration
  def change
    add_reference :students, :specialSchool, index: true
  end
end
