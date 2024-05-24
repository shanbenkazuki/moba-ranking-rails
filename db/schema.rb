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

ActiveRecord::Schema[7.1].define(version: 2024_05_23_135437) do
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
    t.index ["name_en"], name: "index_heroes_on_name_en", unique: true
    t.check_constraint "role::text = ANY (ARRAY['Fighter'::character varying, 'Mage'::character varying, 'Tank'::character varying, 'Assassin'::character varying, 'Marksman'::character varying, 'Support'::character varying]::text[])", name: "role_check"
  end

  add_foreign_key "hero_rates", "heroes"
end
