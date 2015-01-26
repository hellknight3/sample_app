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

ActiveRecord::Schema.define(version: 20150126003046) do

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

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"
  add_index "answers", ["user_id"], name: "index_answers_on_user_id"

  create_table "appointments", force: true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "description"
    t.integer  "pool_id"
  end

  add_index "appointments", ["pool_id"], name: "index_appointments_on_pool_id"

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
    t.boolean  "template"
  end

  create_table "institutions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.string   "message"
    t.integer  "appointment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "patients", force: true do |t|
    t.integer "doctor_id"
    t.boolean "accepted"
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
    t.string  "doctorNotes"
  end

  add_index "patients", ["doctor_id"], name: "index_patients_on_doctor_id"

  create_table "permissions", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "pool_id"
  end

  create_table "pools", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "specialization"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "institutions_id"
  end

  add_index "pools", ["institutions_id"], name: "index_pools_on_institutions_id"

  create_table "questions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "exercise_id"
  end

  add_index "questions", ["exercise_id"], name: "index_questions_on_exercise_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "profile_id"
    t.string   "profile_type"
    t.integer  "pool_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
