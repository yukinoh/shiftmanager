class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts do |t|
      
      t.date :happens_on
      t.string :event_id
      t.string :member_id
      t.boolean :sp_flg
      t.integer :starts_at
      t.integer :ends_at
      t.string :gcal_id
      
      t.timestamps
    end
  end
end
