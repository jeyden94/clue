# == Schema Information
#
# Table name: turns
#
#  id              :bigint           not null, primary key
#  turn_type       :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  game_session_id :integer          not null
#
class Turn < ApplicationRecord
  belongs_to :game_session # Adjust this association based on your schema

  def process_turn(action_params)
    case turn_type
    when "roll"
      process_roll(action_params)
    when "guess"
      process_guess(action_params)
    when "accuse"
      process_accusation(action_params)
    end
  end

  private

  def process_roll(action_params)
    Roll.create(
      session_id: session_id,
      turn_id: id,
      starting_x: action_params[:starting_x],
      starting_y: action_params[:starting_y],
      finishing_x: action_params[:finishing_x],
      finishing_y: action_params[:finishing_y]
    )
    update_board_status(action_params[:finishing_x], action_params[:finishing_y])
  end

  def process_guess(action_params)
    guess = Guess.create(
      session_id: session_id,
      turn_id: id,
      suspect_guessed: action_params[:suspect_guessed],
      weapon_guessed: action_params[:weapon_guessed],
      room_guessed: action_params[:room_guessed]
    )
    reveal_cards_based_on_guess(guess)
  end

  def process_accusation(action_params)
    accusation = Accusation.create(
      session_id: session_id,
      turn_id: id,
      suspect_accused: action_params[:suspect_accused],
      weapon_accused: action_params[:weapon_accused],
      room_accused: action_params[:room_accused]
    )
    check_game_end_condition(accusation)
  end

  def update_board_status(x, y)
    BoardStatus.create(
      session_id: session_id,
      turn_id: id,
      x_coordinate: x,
      y_coordinate: y
    )
  end

  def reveal_cards_based_on_guess(guess)
    # Logic to reveal cards
  end

  def check_game_end_condition(accusation)
    # Logic to determine if the game ends
  end
end
