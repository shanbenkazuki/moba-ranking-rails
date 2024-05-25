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

ActiveRecord::Schema[7.1].define(version: 2024_05_25_085125) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hero_rates", force: :cascade do |t|
    t.bigint "hero_id", null: false
    t.float "win_rate"
    t.float "pick_rate"
    t.float "ban_rate"
    t.date "reference_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hero_id", "reference_date"], name: "index_hero_rates_on_hero_id_and_reference_date", unique: true
    t.index ["hero_id"], name: "index_hero_rates_on_hero_id"
  end

  create_table "heroes", force: :cascade do |t|
    t.string "name_en", null: false
    t.string "name_jp", null: false
    t.string "role", null: false
    t.string "tier_img_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tier"
    t.index ["name_en"], name: "index_heroes_on_name_en", unique: true
    t.check_constraint "role::text = ANY (ARRAY['Fighter'::character varying, 'Mage'::character varying, 'Tank'::character varying, 'Assassin'::character varying, 'Marksman'::character varying, 'Support'::character varying]::text[])", name: "role_check"
    t.check_constraint "tier::text = ANY (ARRAY['S+'::character varying, 'S'::character varying, 'A+'::character varying, 'A'::character varying, 'B'::character varying, 'C'::character varying]::text[])", name: "check_tier_values"
  end

  create_table "pokemon_rates", force: :cascade do |t|
    t.float "win_rate"
    t.float "pick_rate"
    t.float "ban_rate"
    t.date "reference_date", null: false
    t.bigint "pokemon_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pokemon_id", "reference_date"], name: "index_pokemon_rates_on_pokemon_id_and_reference_date", unique: true
    t.index ["pokemon_id"], name: "index_pokemon_rates_on_pokemon_id"
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "name_en", null: false
    t.string "name_jp", null: false
    t.string "style", null: false
    t.string "tier_img_url", null: false
    t.string "tier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name_en"], name: "index_pokemons_on_name_en", unique: true
    t.check_constraint "style::text = ANY (ARRAY['All-Rounder'::character varying, 'Supporter'::character varying, 'Attacker'::character varying, 'Defender'::character varying, 'Speedster'::character varying]::text[])", name: "valid_style"
  end

  add_foreign_key "hero_rates", "heroes"
  add_foreign_key "pokemon_rates", "pokemons"
end
