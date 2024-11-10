class CreateGameSessions < ActiveRecord::Migration[7.1] # Replace 7.1 with your Rails version if different
  def change
    create_table :game_sessions do |t|
      t.integer :murder_weapon
      t.integer :murder_room
      t.integer :murderer
      t.integer :opponent_1
      t.integer :opponent_2
      t.integer :opponent_3
      t.integer :player_character
      t.integer :player_card_1
      t.integer :player_card_2
      t.integer :player_card_3
      t.integer :player_card_4
      t.integer :player_card_5
      t.integer :opponent_1_card_1
      t.integer :opponent_1_card_2
      t.integer :opponent_1_card_3
      t.integer :opponent_1_card_4
      t.integer :opponent_1_card_5
      t.integer :opponent_2_card_1
      t.integer :opponent_2_card_2
      t.integer :opponent_2_card_3
      t.integer :opponent_2_card_4
      t.integer :opponent_3_card_1
      t.integer :opponent_3_card_2
      t.integer :opponent_3_card_3
      t.integer :opponent_3_card_4

      t.timestamps # Adds `created_at` and `updated_at` columns
    end
  end
end
