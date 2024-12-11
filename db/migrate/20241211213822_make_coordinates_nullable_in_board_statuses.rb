class MakeCoordinatesNullableInBoardStatuses < ActiveRecord::Migration[7.0]
  def change
    change_column_null :board_statuses, :x_coordinate, true
    change_column_null :board_statuses, :y_coordinate, true
  end
end
