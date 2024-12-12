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





def calculate_distance(x1, y1, x2, y2)
  Math.sqrt((x2 - x1)**2 + (y2 - y1)**2).round
end






def launch
  @game_session = GameSession.find(params[:session_id])

  # # Get starting or current coordinates
  # @current_x = params[:current_x].present? ? params[:current_x].to_i : 5
  # @current_y = params[:current_y].present? ? params[:current_y].to_i : 5

  # Persist current position or initialize to default
  @current_x = params[:current_x].present? ? params[:current_x].to_i : (session[:current_x] || 5)
  @current_y = params[:current_y].present? ? params[:current_y].to_i : (session[:current_y] || 5)

  # Update session values
  session[:current_x] = @current_x
  session[:current_y] = @current_y

  # Fetch suspects, weapons, and rooms for the scorecard
  @suspects = Suspect.pluck(:suspect_name)
  @weapons = Weapon.pluck(:weapon_name)
  @rooms = Room.pluck(:room_name)

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

  session[:scorecard] ||= {
    suspects: @suspects.map { |suspect| [suspect, false] }.to_h,
    weapons: @weapons.map { |weapon| [weapon, false] }.to_h,
    rooms: @rooms.map { |room| [room, false] }.to_h
  }
  @scorecard = session[:scorecard]

  render({ template: "/game/session" })
end


end
