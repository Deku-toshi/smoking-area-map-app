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

ActiveRecord::Schema[7.1].define(version: 2025_07_29_131023) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "smoking_area_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["smoking_area_id"], name: "index_comments_on_smoking_area_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "smoking_area_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["smoking_area_id"], name: "index_photos_on_smoking_area_id"
  end

  create_table "report_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "report_status_id", null: false
    t.string "target_type"
    t.text "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "targetable_type", null: false
    t.bigint "targetable_id", null: false
    t.index ["report_status_id"], name: "index_reports_on_report_status_id"
    t.index ["targetable_type", "targetable_id"], name: "index_reports_on_targetable"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "smoking_area_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "smoking_area_types", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "smoking_areas", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "smoking_area_status_id", null: false
    t.bigint "smoking_area_type_id", null: false
    t.string "name", null: false
    t.decimal "latitude", precision: 9, scale: 6, null: false
    t.decimal "longitude", precision: 9, scale: 6, null: false
    t.boolean "is_indoor"
    t.string "available_time_type"
    t.time "available_time_start"
    t.time "available_time_end"
    t.string "available_time_note"
    t.text "detail"
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["smoking_area_status_id"], name: "index_smoking_areas_on_smoking_area_status_id"
    t.index ["smoking_area_type_id"], name: "index_smoking_areas_on_smoking_area_type_id"
    t.index ["user_id"], name: "index_smoking_areas_on_user_id"
  end

  create_table "tobacco_types", force: :cascade do |t|
    t.string "kinds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "smoking_areas"
  add_foreign_key "comments", "users"
  add_foreign_key "photos", "smoking_areas"
  add_foreign_key "reports", "report_statuses"
  add_foreign_key "reports", "users"
  add_foreign_key "smoking_areas", "smoking_area_statuses"
  add_foreign_key "smoking_areas", "smoking_area_types"
  add_foreign_key "smoking_areas", "users"
end
