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

ActiveRecord::Schema.define(version: 20151013144857) do

  create_table "events", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "slug",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "date"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "location_id", limit: 4
  end

  add_index "events", ["location_id"], name: "index_events_on_location_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "website",        limit: 255
    t.string   "street_address", limit: 255
    t.string   "city",           limit: 255
    t.string   "postal_code",    limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "locations", ["name"], name: "index_locations_on_name", using: :btree

  create_table "quizzes", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "slug",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
