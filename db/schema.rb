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

ActiveRecord::Schema[8.1].define(version: 2026_01_09_122507) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "applications", force: :cascade do |t|
    t.bigint "applicant_id", null: false
    t.datetime "created_at", null: false
    t.text "message"
    t.bigint "project_id", null: false
    t.string "status", default: "pending", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_applications_on_applicant_id"
    t.index ["project_id", "applicant_id"], name: "index_applications_on_project_id_and_applicant_id", unique: true
    t.index ["project_id"], name: "index_applications_on_project_id"
    t.index ["status"], name: "index_applications_on_status"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "application_id"
    t.datetime "created_at", null: false
    t.datetime "matched_at", null: false
    t.bigint "matched_user_id", null: false
    t.bigint "project_id", null: false
    t.bigint "scout_id"
    t.string "status", default: "active", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_matches_on_application_id"
    t.index ["matched_user_id"], name: "index_matches_on_matched_user_id"
    t.index ["project_id", "matched_user_id"], name: "index_matches_on_project_id_and_matched_user_id", unique: true
    t.index ["project_id"], name: "index_matches_on_project_id"
    t.index ["scout_id"], name: "index_matches_on_scout_id"
    t.index ["status"], name: "index_matches_on_status"
  end

  create_table "portfolio_items", force: :cascade do |t|
    t.date "completed_at"
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "display_order"
    t.bigint "skill_holder_profile_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.string "url"
    t.index ["skill_holder_profile_id"], name: "index_portfolio_items_on_skill_holder_profile_id"
  end

  create_table "project_owner_profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "goals"
    t.text "introduction"
    t.text "past_projects"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_project_owner_profiles_on_user_id", unique: true
  end

  create_table "project_skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "is_primary", default: false
    t.bigint "project_id", null: false
    t.string "required_level"
    t.bigint "skill_id", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "skill_id"], name: "index_project_skills_on_project_id_and_skill_id", unique: true
    t.index ["project_id"], name: "index_project_skills_on_project_id"
    t.index ["skill_id"], name: "index_project_skills_on_skill_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "estimated_period"
    t.bigint "owner_id", null: false
    t.integer "people_needed", default: 1
    t.datetime "published_at"
    t.text "purpose", null: false
    t.string "status", default: "draft"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_projects_on_category"
    t.index ["owner_id"], name: "index_projects_on_owner_id"
    t.index ["published_at"], name: "index_projects_on_published_at"
    t.index ["status"], name: "index_projects_on_status"
  end

  create_table "scouts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "message"
    t.bigint "project_id", null: false
    t.bigint "scout_user_id", null: false
    t.bigint "scouted_user_id", null: false
    t.string "status", default: "pending", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "scouted_user_id"], name: "index_scouts_on_project_id_and_scouted_user_id", unique: true
    t.index ["project_id"], name: "index_scouts_on_project_id"
    t.index ["scout_user_id"], name: "index_scouts_on_scout_user_id"
    t.index ["scouted_user_id"], name: "index_scouts_on_scouted_user_id"
    t.index ["status"], name: "index_scouts_on_status"
  end

  create_table "skill_holder_profiles", force: :cascade do |t|
    t.text "achievements"
    t.string "availability"
    t.datetime "created_at", null: false
    t.text "introduction"
    t.text "past_work"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_skill_holder_profiles_on_user_id", unique: true
  end

  create_table "skills", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.integer "usage_count", default: 0
    t.index ["category"], name: "index_skills_on_category"
    t.index ["name"], name: "index_skills_on_name", unique: true
  end

  create_table "sns_links", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "platform", null: false
    t.datetime "updated_at", null: false
    t.string "url", null: false
    t.bigint "user_id", null: false
    t.boolean "visible_after_match", default: true
    t.index ["user_id", "platform"], name: "index_sns_links_on_user_id_and_platform", unique: true
    t.index ["user_id"], name: "index_sns_links_on_user_id"
  end

  create_table "user_skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "proficiency_level"
    t.bigint "skill_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "years_experience"
    t.index ["skill_id"], name: "index_user_skills_on_skill_id"
    t.index ["user_id", "skill_id"], name: "index_user_skills_on_user_id_and_skill_id", unique: true
    t.index ["user_id"], name: "index_user_skills_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "applications", "projects"
  add_foreign_key "applications", "users", column: "applicant_id"
  add_foreign_key "matches", "applications"
  add_foreign_key "matches", "projects"
  add_foreign_key "matches", "scouts"
  add_foreign_key "matches", "users", column: "matched_user_id"
  add_foreign_key "portfolio_items", "skill_holder_profiles"
  add_foreign_key "project_owner_profiles", "users"
  add_foreign_key "project_skills", "projects"
  add_foreign_key "project_skills", "skills"
  add_foreign_key "projects", "users", column: "owner_id"
  add_foreign_key "scouts", "projects"
  add_foreign_key "scouts", "users", column: "scout_user_id"
  add_foreign_key "scouts", "users", column: "scouted_user_id"
  add_foreign_key "skill_holder_profiles", "users"
  add_foreign_key "sns_links", "users"
  add_foreign_key "user_skills", "skills"
  add_foreign_key "user_skills", "users"
end
