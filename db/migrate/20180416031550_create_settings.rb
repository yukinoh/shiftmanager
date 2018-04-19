class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      
      t.boolean :mon
      t.boolean :tue
      t.boolean :wed
      t.boolean :thu
      t.boolean :fri
      t.boolean :sat
      t.boolean :sun
      t.boolean :hol
      t.boolean :gcal

      t.timestamps
    end
  end
end
