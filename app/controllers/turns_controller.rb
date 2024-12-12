class TurnsController < ApplicationController

  private

  # Calculate Euclidean distance rounded to the nearest whole number
  def calculate_distance(x1, y1, x2, y2)
    Math.sqrt((x2 - x1)**2 + (y2 - y1)**2).round
  end

end
