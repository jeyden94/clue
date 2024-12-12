class TurnsController < ApplicationController

  def make_guess
    @game_session = GameSession.find(params[:game_session_id])
  
    suspect = params[:suspect]
    weapon = params[:weapon]
    room = params[:room]
  
    # Define opponent cards and their respective players
    opponent_cards = [
      { card: @game_session.opponent_1_card_1, opponent: @game_session.opponent_1 },
      { card: @game_session.opponent_1_card_2, opponent: @game_session.opponent_1 },
      { card: @game_session.opponent_1_card_3, opponent: @game_session.opponent_1 },
      { card: @game_session.opponent_1_card_4, opponent: @game_session.opponent_1 },
      { card: @game_session.opponent_1_card_5, opponent: @game_session.opponent_1 },
      { card: @game_session.opponent_2_card_1, opponent: @game_session.opponent_2 },
      { card: @game_session.opponent_2_card_2, opponent: @game_session.opponent_2 },
      { card: @game_session.opponent_2_card_3, opponent: @game_session.opponent_2 },
      { card: @game_session.opponent_2_card_4, opponent: @game_session.opponent_2 },
      { card: @game_session.opponent_3_card_1, opponent: @game_session.opponent_3 },
      { card: @game_session.opponent_3_card_2, opponent: @game_session.opponent_3 },
      { card: @game_session.opponent_3_card_3, opponent: @game_session.opponent_3 },
      { card: @game_session.opponent_3_card_4, opponent: @game_session.opponent_3 }
    ]
  
    # Find the first matching card in opponent cards
    revealed_clue = opponent_cards.find do |entry|
      [suspect, weapon, room].include?(entry[:card])
    end
  
    # Log the guess and clue
    if revealed_clue
      revealed_card = revealed_clue[:card]
      revealer = revealed_clue[:opponent]
      guess_log_entry = "You guessed #{suspect} with the #{weapon} in the #{room}. #{revealer} showed you the #{revealed_card}!"
    else
      guess_log_entry = "You guessed #{suspect} with the #{weapon} in the #{room}, but no one could reveal a clue."
    end
  
    # Add to the session log
    session[:guess_log] ||= []
    session[:guess_log] << guess_log_entry
  
    # Pass guess log to the view
    @guess_log = session[:guess_log]
  
    redirect_to "/session/#{@game_session.id}"
  end
  

  private

  def find_clue(game_session, guess)
    # Define the opponent cards to check
    opponent_cards = [
      { card: game_session.opponent_1_card_1, opponent: game_session.opponent_1 },
      { card: game_session.opponent_1_card_2, opponent: game_session.opponent_1 },
      { card: game_session.opponent_1_card_3, opponent: game_session.opponent_1 },
      { card: game_session.opponent_1_card_4, opponent: game_session.opponent_1 },
      { card: game_session.opponent_1_card_5, opponent: game_session.opponent_1 },
      { card: game_session.opponent_2_card_1, opponent: game_session.opponent_2 },
      { card: game_session.opponent_2_card_2, opponent: game_session.opponent_2 },
      { card: game_session.opponent_2_card_3, opponent: game_session.opponent_2 },
      { card: game_session.opponent_2_card_4, opponent: game_session.opponent_2 },
      { card: game_session.opponent_3_card_1, opponent: game_session.opponent_3 },
      { card: game_session.opponent_3_card_2, opponent: game_session.opponent_3 },
      { card: game_session.opponent_3_card_3, opponent: game_session.opponent_3 },
      { card: game_session.opponent_3_card_4, opponent: game_session.opponent_3 }
    ]

    # Return the first matching clue
    opponent_cards.find do |entry|
      [guess[:suspect], guess[:weapon], guess[:room]].include?(entry[:card])
    end
  end

  
  def confirm_destination
    @game_session = GameSession.find(params[:game_session_id])

    # # Find the player's current location
    # current_square = Square.find_by(x_coordinate: @current_x, y_coordinate: @current_y)

    # Get destination square
    destination_square = Square.find_by(location: params[:destination])
    @distance_to_destination = calculate_distance(@current_x, @current_y, destination_square.x_coordinate, destination_square.y_coordinate)

    # Store destination and distance in session or database
    session[:destination] = params[:destination]
    session[:distance_to_destination] = @distance_to_destination
    session[:roll_sum] = 0 # Reset roll sum
    session[:destination_selected] = true

    flash[:notice] = "Destination confirmed: #{params[:destination]}. Distance: #{@distance_to_destination} spaces."
    redirect_to game_session_path(@game_session.id)
  end



  def roll_dice
    @game_session = GameSession.find(params[:game_session_id])
  
    # Roll a 6-sided dice
    dice_roll = rand(1..6)
  
    # Fetch current and destination coordinates
    @current_x = session[:current_x]
    @current_y = session[:current_y]
    destination_square = Square.find_by(location: params[:destination])
    destination_x = destination_square.x_coordinate
    destination_y = destination_square.y_coordinate
  
    # Calculate movement based on the roll
    new_position = calculate_new_position(@current_x, @current_y, destination_x, destination_y, dice_roll)
  
    # Update session to reflect the new position
    session[:current_x] = new_position[:x]
    session[:current_y] = new_position[:y]
  
    # Store the roll and distance moved in the session
    session[:last_roll] = dice_roll
    session[:last_distance] = new_position[:spaces_moved]
  
    # Check if the destination is reached
    if new_position[:x] == destination_x && new_position[:y] == destination_y
      flash[:notice] = "You reached #{params[:destination]}!"
    else
      flash[:notice] = "You rolled a #{dice_roll} and moved #{new_position[:spaces_moved]} spaces."
    end
  
    # Redirect back to the game session
    redirect_to "/session/#{params[:game_session_id]}"
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
  
  
  
  




  def confirm
      Rails.logger.debug "Parameters Received in Confirm: #{params.inspect}"

    turn = Turn.new(
      game_session_id: params[:game_session_id],
      turn_type: params[:turn_type]
    )
  
    if turn.save
      session[:turn_selected] = true
      session[:roll_selected] = (params[:turn_type] == 'roll')
      session[:destination_selected] = false
  
      Rails.logger.debug "Session Variables After Update: #{session.inspect}"
  
      flash[:notice] = "Turn type '#{params[:turn_type]}' selected successfully!"
    else
      flash[:alert] = "There was an error selecting your turn. Please try again."
    end
  
    redirect_to "/session/#{params[:game_session_id]}"
  end
  
  
  def create
    #POST Turns
    Rails.logger.debug "PARAMS: #{params.inspect}" # Debugging params for future inspection

    turn = Turn.new(turn_params)
    if turn.save
      turn.process_turn(params[:action_params]) # Process the turn logic
      render json: { message: "Turn processed successfully", turn: turn }, status: :created
    else
      render json: { errors: turn.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def turn_params
    # Ensure params include all required fields
    params.require(:turn).permit(:game_session_id, :turn_type)
  end

  private

  # Calculate Euclidean distance rounded to the nearest whole number
  def calculate_distance(x1, y1, x2, y2)
    Math.sqrt((x2 - x1)**2 + (y2 - y1)**2).round
  end


  
  def make_accusation
    @game_session = GameSession.find(params[:game_session_id])
  
    accusation = Accusation.new(
      game_session_id: params[:game_session_id],
      suspect_accused: params[:suspect],
      weapon_accused: params[:weapon],
      room_accused: params[:room]
    )
  
    if accusation.save
      if accusation.suspect_accused == @game_session.murderer &&
         accusation.weapon_accused == @game_session.murder_weapon &&
         accusation.room_accused == @game_session.murder_room
        flash[:notice] = "Congratulations! You solved the mystery!"
      else
        flash[:alert] = "Incorrect accusation. You lost!"
      end
    else
      flash[:alert] = "Failed to make accusation. Please try again."
    end
  
    redirect_to "/session/#{params[:game_session_id]}"
  end
  

end
