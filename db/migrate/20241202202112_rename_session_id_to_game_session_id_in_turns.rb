class RenameSessionIdToGameSessionIdInTurns < ActiveRecord::Migration[6.1]
  def change
    rename_column :turns, :session_id, :game_session_id
  end
end

