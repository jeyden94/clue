class CreateTurns < ActiveRecord::Migration[6.1]
  def change
    create_table :turns do |t|
      t.integer :session_id, null: false
      t.string :turn_type, null: false # 'roll', 'guess', or 'accuse'

      t.timestamps
    end
  end
end
