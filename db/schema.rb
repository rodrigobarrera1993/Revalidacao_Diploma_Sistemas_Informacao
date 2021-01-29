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

ActiveRecord::Schema.define(version: 2021_01_29_181327) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "maneuvers", force: :cascade do |t|
    t.integer "vessel_id"
    t.float "vessel_displacement", null: false
    t.integer "terminal_id"
    t.integer "operator_profile_id"
    t.integer "pilot_profile_id"
    t.integer "relatory_id"
    t.date "date_maneuver", null: false
    t.time "time_maneuver", null: false
    t.boolean "is_finished", default: false
    t.string "type_maneuver", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operator_profile_id"], name: "index_maneuvers_on_operator_profile_id"
    t.index ["pilot_profile_id"], name: "index_maneuvers_on_pilot_profile_id"
    t.index ["relatory_id"], name: "index_maneuvers_on_relatory_id"
    t.index ["terminal_id"], name: "index_maneuvers_on_terminal_id"
    t.index ["vessel_id"], name: "index_maneuvers_on_vessel_id"
  end

  create_table "operator_profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.date "birthdate"
    t.integer "operator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operator_id"], name: "index_operator_profiles_on_operator_id"
  end

  create_table "operators", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_operators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_operators_on_reset_password_token", unique: true
  end

  create_table "pilot_profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.date "birthdate"
    t.integer "pilot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pilot_id"], name: "index_pilot_profiles_on_pilot_id"
  end

  create_table "pilot_statistics", force: :cascade do |t|
    t.integer "pilot_id"
    t.integer "total_maneuvers", default: 0
    t.float "avg_maneuver_safety", default: 0.0
    t.float "avg_ladder_safety", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pilot_id"], name: "index_pilot_statistics_on_pilot_id"
  end

  create_table "pilots", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_pilots_on_email", unique: true
    t.index ["reset_password_token"], name: "index_pilots_on_reset_password_token", unique: true
  end

  create_table "relatories", force: :cascade do |t|
    t.text "maneuver_description"
    t.text "vessel_tendecies"
    t.integer "maneuver_safety"
    t.integer "ladder_safety"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terminals", force: :cascade do |t|
    t.string "name", null: false
    t.string "cargo", null: false
    t.string "url_image", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vessels", force: :cascade do |t|
    t.string "name", null: false
    t.string "mmsi", null: false
    t.float "length", null: false
    t.float "width", null: false
    t.string "type_vessel", null: false
    t.string "url_image", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
