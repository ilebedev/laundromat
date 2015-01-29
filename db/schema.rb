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

  create_table "films", force: true do |t|
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shows", force: true do |t|
    t.string   "image_url"
    t.string   "title"
    t.string   "description"
    t.string   "imdb_link"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  add_index "streams", ["media_id", "media_type"], name: "index_streams_on_media_id_and_media_type"

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
