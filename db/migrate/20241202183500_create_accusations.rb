class CreateAccusations < ActiveRecord::Migration[6.1]
  def change
    create_table :accusations do |t|
      t.integer :session_id, null: false
      t.integer :turn_id, null: false
      t.string :suspect_accused, null: false
      t.string :weapon_accused, null: false
      t.string :room_accused, null: false

      t.timestamps
    end
  end
end
