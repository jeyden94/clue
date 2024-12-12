class GuessesController < ApplicationController

  def clear_guess_log
    session[:guess_log] = [] # Hard reset the guess log
    redirect_to "/session/#{params[:game_session_id] || 1}", notice: "Clue log cleared!" # Hard-code redirection if needed
  end


  
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

end
