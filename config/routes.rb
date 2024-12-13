Rails.application.routes.draw do

  # Home Page and Lobby
  get("/", { :controller => "game", :action => "new" })
  get("/lobby", { :controller => "game", :action => "lobby" })

  # Game Session
  post("/create_and_launch_game", { :controller => "game", :action => "create_and_launch" })
  get("/session/:session_id", { :controller => "game", :action => "launch", :as => "game_session" })

  # Guesses
  post("/make_guess", { :controller => "guesses", :action => "make_guess" })
  post("/clear_guess_log", { :controller => "guesses", :action => "clear_guess_log" })

  # Dice Rolls
  post("/roll_dice", { :controller => "rolls", :action => "roll_dice" })

  # Accusations
  post("/make_accusation", { :controller => "accusations", :action => "make" })
  get("/you_win", { :controller => "accusations", :action => "win" })
  get("/you_lose", { :controller => "accusations", :action => "lose" })

end
