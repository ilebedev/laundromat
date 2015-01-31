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

ActiveRecord::Schema.define(version: 20150131015944) do

  create_table "invites", force: true do |t|
    t.string   "token",           null: false
    t.integer  "user_id"
    t.datetime "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invites", ["user_id"], name: "index_invites_on_user_id"

  create_table "media", force: true do |t|
    t.string   "image_url"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category"
  end

  create_table "requests", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "link"
    t.integer  "votes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category"
  end

  create_table "streams", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imdb_link"
    t.datetime "date_produced"
    t.string   "urls"
    t.string   "media_type"
    t.integer  "media_id"
  end

  add_index "streams", ["media_id"], name: "index_streams_on_media_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "image"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.integer  "role"
    t.datetime "last_seen"
  end

end
