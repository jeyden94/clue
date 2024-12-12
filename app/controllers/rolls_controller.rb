class RollsController < ApplicationController
  def roll_dice
    @game_session = GameSession.find(params[:game_session_id])

    # Roll a 6-sided dice
    dice_roll = rand(1..6)

    # Fetch current and destination coordinates
    current_x = session[:current_x]
    current_y = session[:current_y]
    destination_square = Square.find_by(location: params[:destination])
    destination_x = destination_square.x_coordinate
    destination_y = destination_square.y_coordinate

    # Calculate new position
    new_position = calculate_new_position(current_x, current_y, destination_x, destination_y, dice_roll)

    # Update session with new position
    session[:current_x] = new_position[:x]
    session[:current_y] = new_position[:y]

    # Store the roll and distance moved
    session[:last_roll] = dice_roll
    session[:last_distance] = new_position[:spaces_moved]

    # Update distances to all rooms
    @room_squares = Square.where.not(location: 'Hallway').map do |square|
      distance = calculate_distance(new_position[:x], new_position[:y], square.x_coordinate, square.y_coordinate)
      { name: square.location, distance: distance }
    end

    # Check if the player reached the destination
    if new_position[:x] == destination_x && new_position[:y] == destination_y
      flash[:notice] = "You reached #{params[:destination]}!"
    else
      flash[:notice] = "You rolled a #{dice_roll} and moved #{new_position[:spaces_moved]} spaces."
    end

    # Redirect back to the game session
    redirect_to game_session_path(@game_session.id)
  end

  private

  def calculate_new_position(current_x, current_y, destination_x, destination_y, dice_roll)
    # Calculate the total distance to the destination
    total_distance = Math.sqrt((destination_x - current_x)**2 + (destination_y - current_y)**2).round

    # If the dice roll is greater than or equal to the distance, move directly to the destination
    if dice_roll >= total_distance
      return { x: destination_x, y: destination_y, spaces_moved: total_distance }
    end

    # Otherwise, calculate the new position along the path
    ratio = dice_roll.to_f / total_distance
    new_x = current_x + ((destination_x - current_x) * ratio).round
    new_y = current_y + ((destination_y - current_y) * ratio).round

    # Calculate the actual spaces moved
    spaces_moved = Math.sqrt((new_x - current_x)**2 + (new_y - current_y)**2).round

    { x: new_x, y: new_y, spaces_moved: spaces_moved }
  end

  def calculate_distance(x1, y1, x2, y2)
    Math.sqrt((x2 - x1)**2 + (y2 - y1)**2).round
  end
end
