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

ActiveRecord::Schema.define(version: 20150830033410) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "album_orders", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "album_rights", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "albums", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "art_url"
    t.string   "artists"
    t.string   "flac_arch_url"
    t.string   "mp3_arch_url"
    t.string   "aac_arch_url"
    t.string   "ogg_arch_url"
    t.text     "description"
    t.decimal  "price"
    t.string   "isrc"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "completed", default: false, null: false
  end

  create_table "track_orders", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "track_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "track_rights", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "track_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.integer  "album_id"
    t.string   "name",         null: false
    t.integer  "track_number"
    t.string   "flac_url"
    t.string   "mp3_url"
    t.string   "aac_url"
    t.string   "ogg_url"
    t.string   "sample_url"
    t.string   "description"
    t.decimal  "price"
    t.string   "track_isrc"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "given_name"
    t.string   "family_name"
    t.string   "address_one"
    t.string   "address_two"
    t.string   "address_city"
    t.string   "address_country"
    t.string   "password_hash"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
