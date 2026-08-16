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

ActiveRecord::Schema[8.1].define(version: 2020_08_12_210327) do
  create_table "events", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "date", precision: nil
    t.text "description"
    t.integer "location_id"
    t.boolean "online", default: false
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["date"], name: "index_events_on_date"
    t.index ["location_id"], name: "index_events_on_location_id"
  end

  create_table "locations", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "city"
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.string "postal_code"
    t.string "street_address"
    t.datetime "updated_at", precision: nil, null: false
    t.string "website"
    t.index ["name"], name: "index_locations_on_name"
  end

  create_table "quizzes", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "users", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "updated_at", precision: nil, null: false
  end
end
