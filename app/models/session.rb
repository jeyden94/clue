# == Schema Information
#
# Table name: game_sessions
#
#  id                  :integer          not null, primary key
#  murder_weapon       :integer
#  murder_room         :integer
#  murderer            :integer
#  opponent_1          :integer
#  opponent_2          :integer
#  opponent_3          :integer
#  player_character    :integer
#  player_card_1       :integer
#  player_card_2       :integer
#  player_card_3       :integer
#  player_card_4       :integer
#  player_card_5       :integer
#  opponent_1_card_1   :integer
#  opponent_1_card_2   :integer
#  opponent_1_card_3   :integer
#  opponent_1_card_4   :integer
#  opponent_1_card_5   :integer
#  opponent_2_card_1   :integer
#  opponent_2_card_2   :integer
#  opponent_2_card_3   :integer
#  opponent_2_card_4   :integer
#  opponent_3_card_1   :integer
#  opponent_3_card_2   :integer
#  opponent_3_card_3   :integer
#  opponent_3_card_4   :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null

class Session < ApplicationRecord
end
