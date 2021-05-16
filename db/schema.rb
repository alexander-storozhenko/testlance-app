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

ActiveRecord::Schema.define(version: 2021_05_07_162814) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "mobile_devices", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "platform"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_mobile_devices_on_user_id"
  end

  create_table "question_templates", id: :serial, force: :cascade do |t|
    t.integer "question_type"
    t.integer "number"
    t.string "title"
    t.string "subtitle"
    t.json "answers"
    t.json "true_answers"
    t.json "data"
    t.integer "test_template_id"
    t.index ["test_template_id"], name: "index_question_templates_on_test_template_id"
  end

  create_table "questions", id: :serial, force: :cascade do |t|
    t.integer "number"
    t.json "user_answers", default: {}
    t.integer "user_id"
    t.integer "test_id"
    t.integer "question_template_id"
    t.index ["question_template_id"], name: "index_questions_on_question_template_id"
    t.index ["test_id"], name: "index_questions_on_test_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "recommends", id: :serial, force: :cascade do |t|
    t.string "recommend_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "results", id: :serial, force: :cascade do |t|
    t.integer "test_id"
    t.json "data"
    t.index ["test_id"], name: "index_results_on_test_id"
  end

  create_table "test_recommends", id: :serial, force: :cascade do |t|
    t.integer "recommend_id"
    t.integer "test_template_id"
    t.index ["recommend_id"], name: "index_test_recommends_on_recommend_id"
    t.index ["test_template_id"], name: "index_test_recommends_on_test_template_id"
  end

  create_table "test_templates", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "sub_title"
    t.integer "status", default: 0
    t.integer "likes", default: 0
    t.integer "plays", default: 0
    t.json "options"
    t.json "colors"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_test_templates_on_user_id"
  end

  create_table "tests", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "test_template_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "user_data", default: {}
    t.index ["test_template_id"], name: "index_tests_on_test_template_id"
    t.index ["user_id"], name: "index_tests_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", default: 0, null: false
    t.integer "login_type", default: 0
    t.string "image_url", default: ""
    t.string "google_access_token", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
