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

ActiveRecord::Schema[8.1].define(version: 2024_01_01_000003) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.string "condition_type", null: false
    t.integer "condition_value", null: false
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.string "icon", null: false
    t.string "name", null: false
    t.string "rarity", default: "common"
    t.datetime "updated_at", null: false
    t.integer "xp_bonus", default: 0
  end

  create_table "tasks", force: :cascade do |t|
    t.string "category", default: "geral"
    t.boolean "completed", default: false, null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "difficulty", default: "easy", null: false
    t.date "due_date"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "xp_reward", null: false
    t.index ["user_id", "completed"], name: "index_tasks_on_user_id_and_completed"
    t.index ["user_id", "created_at"], name: "index_tasks_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "user_achievements", force: :cascade do |t|
    t.bigint "achievement_id", null: false
    t.datetime "created_at", null: false
    t.datetime "earned_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["achievement_id"], name: "index_user_achievements_on_achievement_id"
    t.index ["user_id", "achievement_id"], name: "index_user_achievements_on_user_id_and_achievement_id", unique: true
    t.index ["user_id"], name: "index_user_achievements_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "color_theme", default: "purple"
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.date "last_activity_date"
    t.integer "level", default: 1, null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.integer "streak_days", default: 0, null: false
    t.string "theme", default: "dark"
    t.datetime "updated_at", null: false
    t.integer "xp", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "tasks", "users"
  add_foreign_key "user_achievements", "achievements"
  add_foreign_key "user_achievements", "users"
end
