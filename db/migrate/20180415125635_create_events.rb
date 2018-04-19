class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      
      t.string :name
      t.boolean :flg
      t.boolean :mon
      t.boolean :tue
      t.boolean :wed
      t.boolean :thu
      t.boolean :fri
      t.boolean :sat
      t.boolean :sun
      t.boolean :hol
      t.integer :starts_at
      t.integer :ends_at

      t.timestamps
    end
  end
end
