class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      
      t.string :name
      t.boolean :flg
      t.string :email
      t.boolean :gcal_flg

      t.timestamps
    end
  end
end
