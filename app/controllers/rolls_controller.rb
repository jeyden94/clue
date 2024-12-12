class RollsController < ApplicationController
  def roll_dice
    @game_session = GameSession.find(params[:game_session_id])
    Rails.logger.debug "Params received: #{params.inspect}"
    
    # Roll the dice
    dice_roll = rand(1..6)
    
    # Fetch the current position
    current_x = params[:current_x].to_i
    current_y = params[:current_y].to_i

    # Fetch the destination coordinates from the selected destination
    destination_square = Square.find_by(location: params[:destination])
    if destination_square.nil?
      flash[:alert] = "Invalid destination selected."
      redirect_to game_session_path(@game_session.id) and return
    end

    destination_x = destination_square.x_coordinate
    destination_y = destination_square.y_coordinate

    # Calculate the new position
    new_position = calculate_new_position(current_x, current_y, destination_x, destination_y, dice_roll)

    # Update the current position
    @current_x = new_position[:x]
    @current_y = new_position[:y]
    @last_roll = dice_roll

    # Pass data to the view for rendering
    flash[:notice] = "You rolled a #{dice_roll} and moved to (#{@current_x}, #{@current_y})."
    redirect_to game_session_path(@game_session.id, current_x: @current_x, current_y: @current_y)
  end

  private

  # Calculate the distance between two points
  def calculate_distance(x1, y1, x2, y2)
    Math.sqrt((x2 - x1)**2 + (y2 - y1)**2).round
  end

  # Determine the new position after a dice roll
  def calculate_new_position(current_x, current_y, destination_x, destination_y, dice_roll)
    total_distance = calculate_distance(current_x, current_y, destination_x, destination_y)

    if dice_roll >= total_distance
      # Move directly to the destination
      { x: destination_x, y: destination_y }
    else
      # Move proportionally toward the destination
      ratio = dice_roll.to_f / total_distance
      new_x = (current_x + (destination_x - current_x) * ratio).round
      new_y = (current_y + (destination_y - current_y) * ratio).round
      { x: new_x, y: new_y }
    end
  end
end
