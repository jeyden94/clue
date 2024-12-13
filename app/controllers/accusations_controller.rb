class AccusationsController < ApplicationController
  def make
    @game_session = GameSession.find(params[:game_session_id])

    # Fetch the accusation values from params
    accused_suspect = params[:suspect]
    accused_weapon = params[:weapon]
    accused_room = params[:room]

    # Check if the accusation matches the actual values
    if accused_suspect == @game_session.murderer &&
       accused_weapon == @game_session.murder_weapon &&
       accused_room == @game_session.murder_room

      # Redirect to win page if correct
      redirect_to "/you_win"
    else
      # Redirect to lose page if incorrect
      redirect_to "/you_lose"
    end
  end

  def win
    render template: "game/you_win"
  end

  def lose
    render template: "game/you_lose"
  end

end
