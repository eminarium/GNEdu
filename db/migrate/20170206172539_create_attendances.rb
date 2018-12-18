class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances, :id => false, :force => true do |t|
      t.references :contract
      t.references :attendanceSheet
      t.string :attendanceList
      t.text :attendanceNotes

      t.timestamps
    end
    add_index :attendances, :contract_id
    add_index :attendances, :attendanceSheet_id
  end
end
