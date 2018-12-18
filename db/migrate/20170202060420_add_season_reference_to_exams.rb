class AddSeasonReferenceToExams < ActiveRecord::Migration
  def change
    add_reference :exams, :season, index: true
  end
end
