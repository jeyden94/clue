Rails.application.routes.draw do

#-- Game setup --#

  get("/", {:controller => "game", :action => "new" })

  get("/lobby", {:controller => "game", :action => "lobby" })

  post("/create_and_launch_game", { :controller => "game", :action => "create_and_launch" })

  get("/session/:session_id", { :controller => "game", :action => "launch" })

  get("/session/:session_id", { :controller => "game", :action => "launch", :as => "game_session" })




#-- In-Game actions --#

  get("start", {:controller => "clue", :action => "starting_location" })

  get("guess", {:controller => "clue", :action => "guess" })

  get("accuse", {:controller => "clue", :action => "accuse" })

  post("reveal_clue", {:controller => "clue",:action => "reveal"})

  post("create_turn", { :controller => "turns", :action => "create" })

  post("confirm_turn", { :controller => "turns", :action => "confirm" })

  post("confirm_destination", { :controller => "turns", :action => "confirm_destination" })

  post("/make_accusation", { :controller => "turns", :action => "make_accusation" })


#-- Guesses --#

  post("/make_guess", { :controller => "guesses", :action => "make_guess" })

  post("/clear_guess_log", { :controller => "guesses", :action => "clear_guess_log" })


#-- Dice Rolls --#

  post("/roll_dice", { :controller => "rolls", :action => "roll_dice" })



#-- Game setup --#


#-- Guesses --#


#-- Dice Rolls --#











end
