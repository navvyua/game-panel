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

ActiveRecord::Schema.define(version: 20170226163623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id", using: :btree
  end

  create_table "characters", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.text     "biography"
    t.integer  "status",          default: 0
    t.integer  "cash",            default: 500
    t.integer  "bank",            default: 2000
    t.boolean  "driving_license"
    t.string   "faction",         default: "Civilian"
    t.integer  "user_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.text     "deny_reason"
    t.float    "pos_x"
    t.float    "pos_y"
    t.float    "pos_z"
    t.integer  "faction_id",      default: 0
    t.integer  "faction_role",    default: 0
    t.string   "faction_rank"
    t.index ["user_id"], name: "index_characters_on_user_id", using: :btree
  end

  create_table "components", force: :cascade do |t|
    t.integer "character_id"
    t.integer "component"
    t.integer "drawable",     default: 0
    t.integer "texture",      default: 0
    t.integer "palette",      default: 0
  end

  create_table "factions", force: :cascade do |t|
    t.integer  "type"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "news_image"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "role",            default: 0
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.string   "location"
    t.text     "about"
    t.string   "avatar"
    t.boolean  "online",          default: false
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "characters", "users"
end
