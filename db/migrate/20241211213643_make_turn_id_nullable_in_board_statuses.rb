class MakeTurnIdNullableInBoardStatuses < ActiveRecord::Migration[7.0]
  def change
    change_column_null :board_statuses, :turn_id, true
  end
end
