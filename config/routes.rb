Rails.application.routes.draw do

  get("/", {:controller => "game", :action => "new" })

  get("/lobby", {:controller => "game", :action => "lobby" })

  post("/create_game", { :controller => "game", :action => "create" })

  get("/launch_game", {:controller => "game", :action => "launch" })

  get("roll_dice", {:controller => "game", :action => "roll" })

  get("guess", {:controller => "game", :action => "guess" })

  get("accuse", {:controller => "game", :action => "accuse" })

end
