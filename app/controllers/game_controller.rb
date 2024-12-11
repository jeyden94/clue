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

  # Reset session flags for a new game
  session[:turn_selected] = false
  session[:roll_selected] = false
  session[:destination_selected] = false
  session[:destination] = nil
  session[:distance_to_destination] = nil
  session[:roll_sum] = nil

  # Reset player's starting position
  @current_x = 5
  @current_y = 5
  session[:current_x] = @current_x
  session[:current_y] = @current_y

  # Player's color based on their character
  suspect = Suspect.find_by(suspect_name: @game_session.player_character)
  @player_color = suspect.suspect_color

  # Room colors
  @room_colors = {
    "Conservatory" => "green",
    "Ballroom" => "blue",
    "Library" => "brown",
    "Kitchen" => "red",
    "Hall" => "orange",
    "Lounge" => "purple",
    "Dining Room" => "cyan",
    "Billiards Room" => "pink",
    "Study" => "lightgray"
  }

  # Fetch all squares that are rooms and calculate distances
  @room_squares = Square.where.not(location: 'Hallway').map do |square|
    distance = calculate_distance(@current_x, @current_y, square.x_coordinate, square.y_coordinate)
    { name: square.location, distance: distance }
  end

  # Determine the player's current location
  current_square = Square.find_by(x_coordinate: @current_x, y_coordinate: @current_y)
  @current_location = current_square.location

  render({ template: "/game/session" })
end


# def launch
#   @game_session = GameSession.find(params[:session_id])

#   # Reset session flags for a new game
#   session[:turn_selected] = false
#   session[:roll_selected] = false
#   session[:destination_selected] = false
#   session[:destination] = nil
#   session[:distance_to_destination] = nil
#   session[:roll_sum] = nil

#   # Initialize player's starting position
#   @current_x = session[:current_x] || 5
#   @current_y = session[:current_y] || 5
#   session[:current_x] = @current_x
#   session[:current_y] = @current_y

#   # Player's color based on their character
#   suspect = Suspect.find_by(suspect_name: @game_session.player_character)
#   @player_color = suspect.suspect_color

#   # Room colors
#   @room_colors = {
#     "Conservatory" => "green",
#     "Ballroom" => "blue",
#     "Library" => "brown",
#     "Kitchen" => "red",
#     "Hall" => "orange",
#     "Lounge" => "purple",
#     "Dining Room" => "cyan",
#     "Billiards Room" => "pink",
#     "Study" => "lightgray"
#   }

#   # Fetch all squares that are rooms and calculate distances
#   @room_squares = Square.where.not(location: 'Hallway').map do |square|
#     distance = calculate_distance(@current_x, @current_y, square.x_coordinate, square.y_coordinate)
#     { name: square.location, distance: distance }
#   end

#   # Determine the player's current location
#   current_square = Square.find_by(x_coordinate: @current_x, y_coordinate: @current_y)
#   @current_location = current_square.location

#   render({ template: "/game/session" })
# end




private

# Calculate Euclidean distance rounded to the nearest whole number
def calculate_distance(x1, y1, x2, y2)
  Math.sqrt((x2 - x1)**2 + (y2 - y1)**2).round
end


end
