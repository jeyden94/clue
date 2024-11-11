class UpdateSessionTable < ActiveRecord::Migration[7.1]
  def change
    change_column :game_sessions, :murder_weapon, :string
    change_column :game_sessions, :murder_room, :string
    change_column :game_sessions, :murderer, :string
    change_column :game_sessions, :opponent_1, :string
    change_column :game_sessions, :opponent_2, :string
    change_column :game_sessions, :opponent_3, :string
    change_column :game_sessions, :player_character, :string
    change_column :game_sessions, :player_card_1, :string
    change_column :game_sessions, :player_card_2, :string
    change_column :game_sessions, :player_card_3, :string
    change_column :game_sessions, :player_card_4, :string
    change_column :game_sessions, :player_card_5, :string
    change_column :game_sessions, :opponent_1_card_1, :string
    change_column :game_sessions, :opponent_1_card_2, :string
    change_column :game_sessions, :opponent_1_card_3, :string
    change_column :game_sessions, :opponent_1_card_4, :string
    change_column :game_sessions, :opponent_1_card_5, :string
    change_column :game_sessions, :opponent_2_card_1, :string
    change_column :game_sessions, :opponent_2_card_2, :string
    change_column :game_sessions, :opponent_2_card_3, :string
    change_column :game_sessions, :opponent_2_card_4, :string
    change_column :game_sessions, :opponent_3_card_1, :string
    change_column :game_sessions, :opponent_3_card_2, :string    
    change_column :game_sessions, :opponent_3_card_3, :string
    change_column :game_sessions, :opponent_3_card_4, :string
  end
end
