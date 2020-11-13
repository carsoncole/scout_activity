# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_13_191418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.string "duration_days", default: "1"
    t.boolean "is_high_adventure", default: false, null: false
    t.boolean "is_author_volunteering", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "unit_id", null: false
    t.integer "votes_count", default: 0
    t.integer "author_id"
    t.boolean "is_hiking", default: false, null: false
    t.boolean "is_camping", default: false, null: false
    t.boolean "is_swimming", default: false, null: false
    t.boolean "is_plane", default: false, null: false
    t.boolean "is_community_service", default: false, null: false
    t.boolean "is_biking", default: false, null: false
    t.boolean "is_archived", default: false, null: false
    t.boolean "is_cooking", default: false, null: false
    t.boolean "is_merit_badge", default: false, null: false
    t.boolean "is_fundraising", default: false, null: false
    t.boolean "is_international", default: false, null: false
    t.boolean "is_virtual", default: false, null: false
    t.boolean "is_game", default: false, null: false
    t.string "summary_new"
    t.boolean "is_boating", default: false, null: false
    t.integer "copy_count", default: 0
    t.boolean "is_troop", default: false, null: false
    t.boolean "is_pack", default: false, null: false
    t.index ["unit_id"], name: "index_activities_on_unit_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.text "content"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "logs", force: :cascade do |t|
    t.integer "user_id"
    t.integer "unit_it"
    t.string "mailer_instance"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "newsletters", force: :cascade do |t|
    t.string "date"
    t.string "subject"
    t.datetime "sent_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.string "content"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_questions_on_activity_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.boolean "is_polling_active", default: true
    t.integer "votes_allowed", default: 20, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "visit_event_count", default: 0
    t.string "slug"
    t.boolean "is_example", default: false, null: false
    t.index ["slug"], name: "index_units_on_slug", unique: true
    t.index ["visit_event_count"], name: "index_units_on_visit_event_count"
  end

  create_table "users", force: :cascade do |t|
    t.integer "votes_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128
    t.integer "unit_id"
    t.boolean "is_app_admin", default: false
    t.boolean "is_owner", default: false, null: false
    t.boolean "is_subscribed", default: true, null: false
    t.string "token"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "last_sign_in_at"
    t.boolean "is_admin", default: false, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_votes_on_activity_id"
    t.index ["created_at"], name: "index_votes_on_created_at"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "units"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "questions", "activities"
  add_foreign_key "questions", "users"
  add_foreign_key "votes", "activities"
end
