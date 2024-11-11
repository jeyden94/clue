Rails.application.routes.draw do

  get("/", {:controller => "game", :action => "new" })
  get("/lobby", {:controller => "game", :action => "create" })
  post("/session/:id", {:controller => "game", :action => "play" })

end
