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

ActiveRecord::Schema[7.1].define(version: 2024_11_11_201012) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "rooms", force: :cascade do |t|
    t.string "room_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suspects", force: :cascade do |t|
    t.string "suspect_name", null: false
    t.string "suspect_color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weapons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "weapon_name"
  end

end
