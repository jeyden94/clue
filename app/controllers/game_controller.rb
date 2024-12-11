class GameController < ApplicationController

#------------------------------
# Actions to open the app and launch into a new or existing game

def new
  render({ :template => "/game/homepage"})
end

def lobby
  render({ :template => "/game/lobby"})
end

def create_and_launch
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

  @session.opponent_3_card_1 = remaining_cards.pop
  @session.opponent_3_card_2 = remaining_cards.pop
  @session.opponent_3_card_3 = remaining_cards.pop
  @session.opponent_3_card_4 = remaining_cards.pop

  if @session.save
    # Redirect to the launch action for the new session
    redirect_to "/session/#{@session.id}"
  else
    # Handle the case if saving fails (e.g., render an error message or go back to the form)
    redirect_to root_path, alert: "Unable to create game session."
  end
end


def launch
  @game_session = GameSession.find(params[:session_id])

  # Fetch suspects, weapons, and rooms for the scorecard
  @suspects = Suspect.pluck(:suspect_name) # Assuming `Suspect` table exists
  @weapons = Weapon.pluck(:weapon_name)   # Assuming `Weapon` table exists
  @rooms = Room.pluck(:room_name)         # Assuming `Room` table exists

  # Initialize player's starting position
  @current_x = session[:current_x] || 5
  @current_y = session[:current_y] || 5

  # Calculate distances to all room squares
  @room_squares = Square.where.not(location: 'Hallway').map do |square|
    distance = calculate_distance(@current_x, @current_y, square.x_coordinate, square.y_coordinate)
    { name: square.location, distance: distance }
  end

  # Determine the player's current location
  current_square = Square.find_by(x_coordinate: @current_x, y_coordinate: @current_y)
  @current_location = current_square ? current_square.location : 'Unknown'


    # Room colors
  @room_colors = {
    "Conservatory" => "green",
    "Ballroom" => "blue",
    "Library" => "brown",
    "Kitchen" => "red",
    "Hall" => "orange",
    "Lounge" => "purple",
    "Dining room" => "cyan",
    "Billiards room" => "pink",
    "Study" => "lightgray"
  }

  # Initialize the default visibility for the board status
  revealed_items = {
    show_plum: false,
    show_scarlett: false,
    show_mustard: false,
    show_peacock: false,
    show_green: false,
    show_white: false,
    show_candle_stick: false,
    show_wrench: false,
    show_lead_pipe: false,
    show_rope: false,
    show_dagger: false,
    show_revolver: false,
    show_hall: false,
    show_study: false,
    show_ballroom: false,
    show_billiards_room: false,
    show_dining_room: false,
    show_kitchen: false,
    show_lounge: false,
    show_conservatory: false,
    show_library: false
  }

  # Mark any items in the player's hand as revealed
  player_cards = [
    @game_session.player_card_1,
    @game_session.player_card_2,
    @game_session.player_card_3,
    @game_session.player_card_4,
    @game_session.player_card_5
  ]

  player_cards.each do |card|
    case card
    when "Professor Plum" then revealed_items[:show_plum] = true
    when "Miss Scarlett" then revealed_items[:show_scarlett] = true
    when "Colonel Mustard" then revealed_items[:show_mustard] = true
    when "Mrs. Peacock" then revealed_items[:show_peacock] = true
    when "Mr. Green" then revealed_items[:show_green] = true
    when "Mrs. White" then revealed_items[:show_white] = true
    when "Candlestick" then revealed_items[:show_candle_stick] = true
    when "Wrench" then revealed_items[:show_wrench] = true
    when "Lead Pipe" then revealed_items[:show_lead_pipe] = true
    when "Rope" then revealed_items[:show_rope] = true
    when "Dagger" then revealed_items[:show_dagger] = true
    when "Revolver" then revealed_items[:show_revolver] = true
    when "Hall" then revealed_items[:show_hall] = true
    when "Study" then revealed_items[:show_study] = true
    when "Ballroom" then revealed_items[:show_ballroom] = true
    when "Billiards room" then revealed_items[:show_billiards_room] = true
    when "Dining room" then revealed_items[:show_dining_room] = true
    when "Kitchen" then revealed_items[:show_kitchen] = true
    when "Lounge" then revealed_items[:show_lounge] = true
    when "Conservatory" then revealed_items[:show_conservatory] = true
    when "Library" then revealed_items[:show_library] = true
    end
  end

  # Create a new BoardStatus record for this session
  @board_status = BoardStatus.create!(
    session_id: @game_session.id,
    turn_id: nil, # No turn associated yet
    **revealed_items
  )

  render({ template: "/game/session" })
end



private

# Calculate Euclidean distance rounded to the nearest whole number
def calculate_distance(x1, y1, x2, y2)
  Math.sqrt((x2 - x1)**2 + (y2 - y1)**2).round
end


end
