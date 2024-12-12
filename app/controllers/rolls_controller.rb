class RollsController < ApplicationController
  def roll_dice
    # Fetch session info
    @game_session = GameSession.find(params[:game_session_id])

    # Current and destination coordinates
    current_x = session[:current_x]
    current_y = session[:current_y]
    destination_square = Square.find_by(location: params[:destination])
    destination_x = destination_square&.x_coordinate
    destination_y = destination_square&.y_coordinate

    # Calculate original distance
    original_distance = calculate_distance(current_x, current_y, destination_x, destination_y) if destination_x && destination_y

    # Roll a dice
    roll_value = rand(1..6)

    # Update new position and calculate remaining distance
    new_position = calculate_new_position(current_x, current_y, destination_x, destination_y, roll_value)
    remaining_distance = calculate_distance(new_position[:x], new_position[:y], destination_x, destination_y) if destination_x && destination_y

    # Save new position to session
    session[:current_x] = new_position[:x]
    session[:current_y] = new_position[:y]

    # Determine locations
    start_location = Square.find_by(x_coordinate: current_x, y_coordinate: current_y)&.location || "Unknown"
    end_location = Square.find_by(x_coordinate: new_position[:x], y_coordinate: new_position[:y])&.location || "Unknown"

    # Populate debugging info
    @roll_debug = {
      start_x: current_x,
      start_y: current_y,
      start_location: start_location,
      destination: destination_square&.location || "Unknown",
      original_distance: original_distance,
      roll_value: roll_value,
      remaining_distance: remaining_distance
    }

    # Render or redirect
    redirect_to "/session/#{@game_session.id}", notice: "Roll completed!"
  end

  private

  def calculate_distance(x1, y1, x2, y2)
    Math.sqrt((x2 - x1)**2 + (y2 - y1)**2).round
  end

  def calculate_new_position(current_x, current_y, destination_x, destination_y, dice_roll)
    # Logic for updating the player's position
    total_distance = calculate_distance(current_x, current_y, destination_x, destination_y)

    # If roll is greater than or equal to the distance, move directly to destination
    if dice_roll >= total_distance
      { x: destination_x, y: destination_y }
    else
      # Calculate intermediate position
      ratio = dice_roll.to_f / total_distance
      new_x = (current_x + (destination_x - current_x) * ratio).round
      new_y = (current_y + (destination_y - current_y) * ratio).round
      { x: new_x, y: new_y }
    end
  end
end





















# class RollsController < ApplicationController
#   def roll_dice
#     @game_session = GameSession.find(params[:game_session_id])

#     # Fetch current position and selected destination
#     current_x = params[:current_x].to_i
#     current_y = params[:current_y].to_i
#     destination_name = params[:destination]
#     destination_square = Square.find_by(location: destination_name)

#     unless destination_square
#       flash[:alert] = "Invalid destination selected."
#       redirect_to "/session/#{@game_session.id}?current_x=#{current_x}&current_y=#{current_y}"
#       return
#     end

#     destination_x = destination_square.x_coordinate
#     destination_y = destination_square.y_coordinate

#     # Roll the dice
#     dice_roll = rand(1..6)

#     # Calculate the new position
#     new_position = calculate_new_position(current_x, current_y, destination_x, destination_y, dice_roll)

#     # Update the current position and location
#     @current_x = new_position[:x]
#     @current_y = new_position[:y]
#     @current_location = determine_location(@current_x, @current_y)

#     # Check if the player has reached the destination
#     if @current_x == destination_x && @current_y == destination_y
#       flash[:notice] = "You rolled a #{dice_roll} and reached #{destination_name}!"
#     else
#       flash[:notice] = "You rolled a #{dice_roll} and moved closer to #{destination_name}."
#     end

#     @last_roll = dice_roll
#     @last_distance = new_position[:spaces_moved]
    

#     # Redirect with updated coordinates
#     redirect_to "/session/#{@game_session.id}?current_x=#{@current_x}&current_y=#{@current_y}"
#   end

#   private

#   def calculate_new_position(current_x, current_y, destination_x, destination_y, dice_roll)
#     # Calculate total distance
#     total_distance = Math.sqrt((destination_x - current_x)**2 + (destination_y - current_y)**2).round

#     # If dice roll >= total distance, move directly to destination
#     return { x: destination_x, y: destination_y, spaces_moved: total_distance } if dice_roll >= total_distance

#     # Otherwise, calculate new position
#     ratio = dice_roll.to_f / total_distance
#     new_x = current_x + ((destination_x - current_x) * ratio).round
#     new_y = current_y + ((destination_y - current_y) * ratio).round

#     { x: new_x, y: new_y, spaces_moved: dice_roll }
#   end

#   def determine_location(x, y)
#     square = Square.find_by(x_coordinate: x, y_coordinate: y)
#     square&.location || "Hallway"
#   end
# end
