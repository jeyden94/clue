class CreateBoardStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :board_statuses do |t|
      t.integer :session_id, null: false
      t.integer :turn_id, null: false
      t.integer :x_coordinate, null: false
      t.integer :y_coordinate, null: false

      # Columns for revealing cards
      t.boolean :show_plum, default: false
      t.boolean :show_scarlett, default: false
      t.boolean :show_mustard, default: false
      t.boolean :show_peacock, default: false
      t.boolean :show_green, default: false
      t.boolean :show_white, default: false
      t.boolean :show_candle_stick, default: false
      t.boolean :show_wrench, default: false
      t.boolean :show_lead_pipe, default: false
      t.boolean :show_rope, default: false
      t.boolean :show_dagger, default: false
      t.boolean :show_revolver, default: false
      t.boolean :show_hall, default: false
      t.boolean :show_study, default: false
      t.boolean :show_ballroom, default: false
      t.boolean :show_billiards_room, default: false
      t.boolean :show_dining_room, default: false
      t.boolean :show_kitchen, default: false
      t.boolean :show_lounge, default: false
      t.boolean :show_conservatory, default: false
      t.boolean :show_library, default: false

      t.timestamps
    end
  end
end
