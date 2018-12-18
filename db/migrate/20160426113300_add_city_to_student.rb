class AddCityToStudent < ActiveRecord::Migration
  def change
    add_reference :students, :city, index: true
  end
end
