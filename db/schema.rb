# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_12_02_183545) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accusations", force: :cascade do |t|
    t.integer "session_id", null: false
    t.integer "turn_id", null: false
    t.string "suspect_accused", null: false
    t.string "weapon_accused", null: false
    t.string "room_accused", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "board_statuses", force: :cascade do |t|
    t.integer "session_id", null: false
    t.integer "turn_id", null: false
    t.integer "x_coordinate", null: false
    t.integer "y_coordinate", null: false
    t.boolean "show_plum", default: false
    t.boolean "show_scarlett", default: false
    t.boolean "show_mustard", default: false
    t.boolean "show_peacock", default: false
    t.boolean "show_green", default: false
    t.boolean "show_white", default: false
    t.boolean "show_candle_stick", default: false
    t.boolean "show_wrench", default: false
    t.boolean "show_lead_pipe", default: false
    t.boolean "show_rope", default: false
    t.boolean "show_dagger", default: false
    t.boolean "show_revolver", default: false
    t.boolean "show_hall", default: false
    t.boolean "show_study", default: false
    t.boolean "show_ballroom", default: false
    t.boolean "show_billiards_room", default: false
    t.boolean "show_dining_room", default: false
    t.boolean "show_kitchen", default: false
    t.boolean "show_lounge", default: false
    t.boolean "show_conservatory", default: false
    t.boolean "show_library", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_sessions", force: :cascade do |t|
    t.string "murder_weapon"
    t.string "murder_room"
    t.string "murderer"
    t.string "opponent_1"
    t.string "opponent_2"
    t.string "opponent_3"
    t.string "player_character"
    t.string "player_card_1"
    t.string "player_card_2"
    t.string "player_card_3"
    t.string "player_card_4"
    t.string "player_card_5"
    t.string "opponent_1_card_1"
    t.string "opponent_1_card_2"
    t.string "opponent_1_card_3"
    t.string "opponent_1_card_4"
    t.string "opponent_1_card_5"
    t.string "opponent_2_card_1"
    t.string "opponent_2_card_2"
    t.string "opponent_2_card_3"
    t.string "opponent_2_card_4"
    t.string "opponent_3_card_1"
    t.string "opponent_3_card_2"
    t.string "opponent_3_card_3"
    t.string "opponent_3_card_4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guesses", force: :cascade do |t|
    t.integer "session_id", null: false
    t.integer "turn_id", null: false
    t.string "suspect_guessed", null: false
    t.string "weapon_guessed", null: false
    t.string "room_guessed", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rolls", force: :cascade do |t|
    t.integer "session_id", null: false
    t.integer "turn_id", null: false
    t.integer "starting_x", null: false
    t.integer "starting_y", null: false
    t.integer "finishing_x", null: false
    t.integer "finishing_y", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "room_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "squares", force: :cascade do |t|
    t.string "location"
    t.integer "x_coordinate"
    t.integer "y_coordinate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suspects", force: :cascade do |t|
    t.string "suspect_name", null: false
    t.string "suspect_color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turns", force: :cascade do |t|
    t.integer "session_id", null: false
    t.string "turn_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weapons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "weapon_name"
  end

end
