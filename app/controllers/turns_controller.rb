class TurnsController < ApplicationController
  # POST /turns
  def create
    Rails.logger.debug "PARAMS: #{params.inspect}" # Add this line
    turn = Turn.new(turn_params)
    if turn.save
      turn.process_turn(params[:action_params]) # Pass additional action-specific data
      render json: { message: "Turn processed successfully", turn: turn }, status: :created
    else
      render json: { errors: turn.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def turn_params
    params.require(:turn).permit(:game_session_id, :turn_type)
  end
end
