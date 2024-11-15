class ClueController < ApplicationController

def starting_location
  @starting_location = Square.where(x_coordinate: 5, y_coordinate: 5).first
end
  
def roll
end

def guess
end

def accuse
end

def reveal
end

end
