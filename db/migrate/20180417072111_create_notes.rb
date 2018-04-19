class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      
      t.date :created_for
      t.text :content

      t.timestamps
    end
  end
end
