Rails.application.routes.draw do

  get("/", {:controller => "game", :action => "new" })

  get("/lobby", {:controller => "game", :action => "lobby" })

  post("/create_game", { :controller => "game", :action => "create" })

  get("/launch_game", {:controller => "game", :action => "launch" })

end
