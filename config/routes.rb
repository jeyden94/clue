Rails.application.routes.draw do

#-- Game setup --#

  get("/", {:controller => "game", :action => "new" })

  get("/lobby", {:controller => "game", :action => "lobby" })

  post("/create_and_launch_game", { :controller => "game", :action => "create_and_launch" })

  get("/session/:session_id", { :controller => "game", :action => "launch" })


#-- In-Game actions --#

  get("start", {:controller => "clue", :action => "starting_location" })

  get("roll_dice", {:controller => "clue", :action => "roll" })

  get("guess", {:controller => "clue", :action => "guess" })

  get("accuse", {:controller => "clue", :action => "accuse" })

  post("reveal_clue", {:controller => "clue",:action => "reveal"})

end
