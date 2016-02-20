# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160220085936) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deck_cards", force: :cascade do |t|
    t.integer  "deck_id",    null: false
    t.integer  "card_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_deck_cards_on_card_id", using: :btree
    t.index ["deck_id"], name: "index_deck_cards_on_deck_id", using: :btree
  end

  create_table "decks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_cards", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "card_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_game_cards_on_card_id", using: :btree
    t.index ["game_id"], name: "index_game_cards_on_game_id", using: :btree
    t.index ["user_id"], name: "index_game_cards_on_user_id", using: :btree
  end

  create_table "game_decks", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "deck_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deck_id"], name: "index_game_decks_on_deck_id", using: :btree
    t.index ["game_id"], name: "index_game_decks_on_game_id", using: :btree
  end

  create_table "games", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "bet",                      null: false
    t.integer  "admin_id",                 null: false
    t.integer  "winner_id"
    t.integer  "winning_type", default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["user_id"], name: "index_games_on_user_id", using: :btree
  end

  create_table "steps", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "game_card_id"
    t.integer  "kind",         default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["game_card_id"], name: "index_steps_on_game_card_id", using: :btree
    t.index ["game_id"], name: "index_steps_on_game_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                       null: false
    t.boolean  "admin",      default: false
    t.integer  "blackjacks", default: 0,     null: false
    t.integer  "busts",      default: 0,     null: false
    t.integer  "majorities", default: 0,     null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_foreign_key "deck_cards", "cards"
  add_foreign_key "deck_cards", "decks"
  add_foreign_key "game_cards", "cards"
  add_foreign_key "game_cards", "games"
  add_foreign_key "game_cards", "users"
  add_foreign_key "game_decks", "decks"
  add_foreign_key "game_decks", "games"
  add_foreign_key "games", "users"
  add_foreign_key "steps", "game_cards"
  add_foreign_key "steps", "games"
end
