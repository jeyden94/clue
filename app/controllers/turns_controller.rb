class TurnsController < ApplicationController

  
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
