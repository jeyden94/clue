Rails.application.routes.draw do

  get("/", {:controller => "game", :action => "new" })

  get("/lobby", {:controller => "game", :action => "lobby" })

  post("/create_game", { :controller => "game", :action => "create" })

  # post("/lobby", {:controller => "game", :action => "play"})

  # post("/create_game", { :controller => "courses", :action => "create" })

  # get("/session/:path_id", {:controller => "game", :action => "launch" })
end
