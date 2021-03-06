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

ActiveRecord::Schema.define(version: 20150407055278) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", id: false, force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visited",    default: false
    t.integer  "user_id"
  end

  add_index "countries", ["code", "user_id"], name: "country_code_user_id_idx", using: :btree
  add_index "countries", ["user_id"], name: "country_user_id_idx", using: :btree

  create_table "currencies", id: false, force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country_id"
    t.float    "weight"
    t.float    "collector_value"
    t.integer  "user_id"
  end

  add_index "currencies", ["code", "user_id"], name: "currency_code_user_id_idx", using: :btree
  add_index "currencies", ["country_id"], name: "currency_country_id_idx", using: :btree
  add_index "currencies", ["user_id"], name: "currency_user_id_idx", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "api_key"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
