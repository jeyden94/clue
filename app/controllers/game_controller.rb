class GameController < ApplicationController

#------------------------------
# Actions to open the app and launch into a new or existing game

def new
  render({ :template => "/game/homepage"})
end

def lobby
  render({ :template => "game/lobby"})
end

def create
  @session = GameSession.new

  @session.murder_weapon = Weapon.order("RANDOM()").first.weapon_name
  @session.murder_room = Room.order("RANDOM()").first.room_name
  @session.murderer = Suspect.order("RANDOM()").first.suspect_name

  @session.player_character = params.fetch("query_player_character_id")
  @session.opponent_1 = params.fetch("query_opponent_one_id")
  @session.opponent_2 = params.fetch("query_opponent_two_id")
  @session.opponent_3 = params.fetch("query_opponent_three_id")
 
  remaining_weapons = Weapon.where.not(weapon_name: @session.murder_weapon).pluck(:weapon_name)
  remaining_rooms = Room.where.not(room_name: @session.murder_room).pluck(:room_name)
  remaining_suspects = Suspect.where.not(suspect_name: @session.murderer).pluck(:suspect_name)

  remaining_cards = (remaining_weapons + remaining_rooms + remaining_suspects).shuffle

  @session.player_card_1 = remaining_cards.pop
  @session.player_card_2 = remaining_cards.pop
  @session.player_card_3 = remaining_cards.pop
  @session.player_card_4 = remaining_cards.pop
  @session.player_card_5 = remaining_cards.pop

  @session.opponent_1_card_1 = remaining_cards.pop
  @session.opponent_1_card_2 = remaining_cards.pop
  @session.opponent_1_card_3 = remaining_cards.pop
  @session.opponent_1_card_4 = remaining_cards.pop
  @session.opponent_1_card_5 = remaining_cards.pop

  @session.opponent_2_card_1 = remaining_cards.pop
  @session.opponent_2_card_2 = remaining_cards.pop
  @session.opponent_2_card_3 = remaining_cards.pop
  @session.opponent_2_card_4 = remaining_cards.pop

  @session.opponent_3_card_2 = remaining_cards.pop
  @session.opponent_3_card_1 = remaining_cards.pop
  @session.opponent_3_card_3 = remaining_cards.pop
  @session.opponent_3_card_4 = remaining_cards.pop

  @session.save
end



# def select


# end

end
