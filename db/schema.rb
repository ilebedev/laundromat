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

ActiveRecord::Schema.define(version: 20150129042944) do

  create_table "invites", force: true do |t|
    t.string   "token",      null: false
    t.integer  "user_id"
    t.string   "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invites", ["user_id"], name: "index_invites_on_user_id"

  create_table "media", force: true do |t|
    t.string   "image_url"
    t.string   "title"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: true do |t|
    t.string   "request"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "streams", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "imdb_link"
    t.datetime "date_produced"
    t.string   "image_url"
    t.string   "video_urls"
    t.string   "subtitle_urls"
    t.integer  "medium_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "streams", ["medium_id"], name: "index_streams_on_medium_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "image"
    t.string   "email"
    t.integer  "role"
    t.datetime "last_seen"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
  end

end
