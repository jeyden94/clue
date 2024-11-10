class GameController < ApplicationController

#------------------------------
# Actions to open the app and launch into a new or existing game

def new
  render({ :template => "/game/homepage"})
end

def create
  render({ :template => "game/lobby"})
end

end
