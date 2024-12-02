class CreateGuesses < ActiveRecord::Migration[6.1]
  def change
    create_table :guesses do |t|
      t.integer :session_id, null: false
      t.integer :turn_id, null: false
      t.string :suspect_guessed, null: false
      t.string :weapon_guessed, null: false
      t.string :room_guessed, null: false

      t.timestamps
    end
  end
end
