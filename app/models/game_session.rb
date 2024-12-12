# == Schema Information
#
# Table name: game_sessions
#
#  id                :bigint           not null, primary key
#  murder_room       :string
#  murder_weapon     :string
#  murderer          :string
#  opponent_1        :string
#  opponent_1_card_1 :string
#  opponent_1_card_2 :string
#  opponent_1_card_3 :string
#  opponent_1_card_4 :string
#  opponent_1_card_5 :string
#  opponent_2        :string
#  opponent_2_card_1 :string
#  opponent_2_card_2 :string
#  opponent_2_card_3 :string
#  opponent_2_card_4 :string
#  opponent_3        :string
#  opponent_3_card_1 :string
#  opponent_3_card_2 :string
#  opponent_3_card_3 :string
#  opponent_3_card_4 :string
#  player_card_1     :string
#  player_card_2     :string
#  player_card_3     :string
#  player_card_4     :string
#  player_card_5     :string
#  player_character  :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class GameSession < ApplicationRecord
  has_many :turns # Optional: if you want to define the reverse association
  def card_type(card_name)
    if Room.exists?(room_name: card_name)
      "Room"
    elsif Weapon.exists?(weapon_name: card_name)
      "Weapon"
    elsif Suspect.exists?(suspect_name: card_name)
      "Suspect"
    else
      "Unknown"
    end
  end
end
