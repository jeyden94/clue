class ScorecardsController < ApplicationController
  before_action :initialize_scorecard, only: [:save_scorecard]

  def save_scorecard
    params.each do |key, value|
      if key.start_with?("suspect_")
        suspect_name = key.sub("suspect_", "")
        session[:scorecard][:suspects][suspect_name] = (value == "true")
      elsif key.start_with?("weapon_")
        weapon_name = key.sub("weapon_", "")
        session[:scorecard][:weapons][weapon_name] = (value == "true")
      elsif key.start_with?("room_")
        room_name = key.sub("room_", "")
        session[:scorecard][:rooms][room_name] = (value == "true")
      end
    end

    redirect_to game_session_path(params[:game_session_id]), notice: "Scorecard saved!"

    Rails.logger.debug "Updated scorecard: #{session[:scorecard]}"

  end

  private

  # Ensure session[:scorecard] and its nested keys are initialized
  def initialize_scorecard
    session[:scorecard] ||= {}
    session[:scorecard][:suspects] ||= {}
    session[:scorecard][:weapons] ||= {}
    session[:scorecard][:rooms] ||= {}
  end
end
