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

ActiveRecord::Schema.define(version: 20180417072111) do

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.boolean "flg"
    t.boolean "mon"
    t.boolean "tue"
    t.boolean "wed"
    t.boolean "thu"
    t.boolean "fri"
    t.boolean "sat"
    t.boolean "sun"
    t.boolean "hol"
    t.integer "starts_at"
    t.integer "ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.boolean "flg"
    t.string "email"
    t.boolean "gcal_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.date "created_for"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.boolean "mon"
    t.boolean "tue"
    t.boolean "wed"
    t.boolean "thu"
    t.boolean "fri"
    t.boolean "sat"
    t.boolean "sun"
    t.boolean "hol"
    t.boolean "gcal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shifts", force: :cascade do |t|
    t.date "happens_on"
    t.string "event_id"
    t.string "member_id"
    t.boolean "sp_flg"
    t.integer "starts_at"
    t.integer "ends_at"
    t.string "gcal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
