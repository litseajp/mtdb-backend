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

ActiveRecord::Schema[7.1].define(version: 2024_02_03_073438) do
  create_table "constant_intervals", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "semitone_distance", null: false
    t.integer "alphabet_distance", null: false
  end

  create_table "constant_mid_scale_intervals", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "scale_id"
    t.bigint "interval_id"
    t.bigint "tonetype_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interval_id"], name: "index_constant_mid_scale_intervals_on_interval_id"
    t.index ["scale_id"], name: "index_constant_mid_scale_intervals_on_scale_id"
    t.index ["tonetype_id"], name: "index_constant_mid_scale_intervals_on_tonetype_id"
  end

  create_table "constant_scale_categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "constant_scale_tonetypes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "constant_scales", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "scale_category_id"
    t.string "path", null: false
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scale_category_id"], name: "index_constant_scales_on_scale_category_id"
  end

  add_foreign_key "constant_mid_scale_intervals", "constant_intervals", column: "interval_id"
  add_foreign_key "constant_mid_scale_intervals", "constant_scale_tonetypes", column: "tonetype_id"
  add_foreign_key "constant_mid_scale_intervals", "constant_scales", column: "scale_id"
  add_foreign_key "constant_scales", "constant_scale_categories", column: "scale_category_id"
end
