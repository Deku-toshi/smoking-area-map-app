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

ActiveRecord::Schema[7.1].define(version: 2025_11_22_033736) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "smoking_area_tobacco_types", force: :cascade do |t|
    t.bigint "smoking_area_id", null: false
    t.bigint "tobacco_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["smoking_area_id", "tobacco_type_id"], name: "idx_on_smoking_area_id_tobacco_type_id_bc76b2e19e", unique: true
    t.index ["smoking_area_id"], name: "index_smoking_area_tobacco_types_on_smoking_area_id"
    t.index ["tobacco_type_id"], name: "index_smoking_area_tobacco_types_on_tobacco_type_id"
  end

  create_table "smoking_areas", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "latitude", precision: 9, scale: 6, null: false
    t.decimal "longitude", precision: 9, scale: 6, null: false
    t.boolean "is_indoor"
    t.text "detail"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tobacco_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "icon", null: false
    t.integer "display_order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["display_order"], name: "index_tobacco_types_on_display_order", unique: true
    t.index ["name"], name: "index_tobacco_types_on_name", unique: true
  end

  add_foreign_key "smoking_area_tobacco_types", "smoking_areas"
  add_foreign_key "smoking_area_tobacco_types", "tobacco_types"
end
