class AddHighSchoolRefToStudent < ActiveRecord::Migration
  def change
    add_reference :students, :highSchool, index: true
  end
end
