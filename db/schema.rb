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

ActiveRecord::Schema.define(version: 20150814211932) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "message"
  end

  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "admins", force: true do |t|
    t.boolean "director"
  end

  create_table "answers", force: true do |t|
    t.text     "response"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
    t.integer  "user_id"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "appointment_memberships", force: true do |t|
    t.integer  "appointment_id"
    t.integer  "pool_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "appointment_memberships", ["appointment_id"], name: "index_appointment_memberships_on_appointment_id", using: :btree
  add_index "appointment_memberships", ["pool_id"], name: "index_appointment_memberships_on_pool_id", using: :btree

  create_table "appointments", force: true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "description"
    t.integer  "pool_id"
  end

  add_index "appointments", ["pool_id"], name: "index_appointments_on_pool_id", using: :btree

  create_table "doc_relationships", force: true do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.boolean  "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doctors", force: true do |t|
  end

  create_table "exercise_settings", force: true do |t|
    t.integer  "exercise_id"
    t.integer  "pool_id"
    t.boolean  "template"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "institution_memberships", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "institution_id"
    t.integer  "memberable_id"
    t.string   "memberable_type"
  end

  add_index "institution_memberships", ["memberable_id", "memberable_type"], name: "index_institution_memberable", using: :btree

  create_table "institutions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.integer  "defaultMessageNumber"
  end

  create_table "messages", force: true do |t|
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "messageable_id"
    t.string   "messageable_type"
  end

  create_table "notes", force: true do |t|
    t.string   "content"
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", force: true do |t|
    t.string  "emergencyContact"
    t.string  "emergencyPhoneNumber"
    t.date    "dateOfBirth"
    t.string  "familyDoctor"
    t.integer "healthCardNumber"
    t.string  "phoneNumber"
    t.integer "weight"
    t.integer "height"
    t.string  "currentMedication"
    t.string  "currentIssue"
  end

  create_table "permissions", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "pool_id"
    t.boolean "accepted"
  end

  create_table "pools", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "specialization"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "institutions_id"
    t.integer  "institution_id"
  end

  add_index "pools", ["institutions_id"], name: "index_pools_on_institutions_id", using: :btree

  create_table "questions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "exercise_id"
  end

  add_index "questions", ["exercise_id"], name: "index_questions_on_exercise_id", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profile_id"
    t.string   "profile_type"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "perishable_token"
    t.integer  "login_count",        default: 0,     null: false
    t.integer  "failed_login_count", default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.boolean  "active",             default: false
    t.boolean  "verified",           default: false
    t.boolean  "approved",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
