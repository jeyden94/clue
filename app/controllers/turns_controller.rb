class TurnsController < ApplicationController

  def confirm
    # Create a new Turn record
    turn = Turn.new(
      game_session_id: params[:game_session_id],
      turn_type: params[:turn_type]
    )

    if turn.save
      flash[:notice] = "Turn type '#{params[:turn_type]}' selected successfully!"
    else
      flash[:alert] = "There was an error selecting your turn. Please try again."
    end

    # Redirect back to the game session view
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
end
