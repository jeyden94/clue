class CreateRolls < ActiveRecord::Migration[6.1]
  def change
    create_table :rolls do |t|
      t.integer :session_id, null: false
      t.integer :turn_id, null: false
      t.integer :starting_x, null: false
      t.integer :starting_y, null: false
      t.integer :finishing_x, null: false
      t.integer :finishing_y, null: false

      t.timestamps
    end
  end
end
