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

ActiveRecord::Schema.define(version: 20151005205615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "album_orders", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "album_id"
    t.decimal  "price"
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
    t.string   "name",                             null: false
    t.string   "art_url"
    t.string   "artists"
    t.text     "description"
    t.decimal  "price",             default: 10.0, null: false
    t.string   "isrc"
    t.string   "year"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "mp3_file_name"
    t.string   "mp3_content_type"
    t.integer  "mp3_file_size"
    t.datetime "mp3_updated_at"
    t.string   "alac_file_name"
    t.string   "alac_content_type"
    t.integer  "alac_file_size"
    t.datetime "alac_updated_at"
    t.string   "aac_file_name"
    t.string   "aac_content_type"
    t.integer  "aac_file_size"
    t.datetime "aac_updated_at"
    t.string   "ogg_file_name"
    t.string   "ogg_content_type"
    t.integer  "ogg_file_size"
    t.datetime "ogg_updated_at"
    t.string   "flac_file_name"
    t.string   "flac_content_type"
    t.integer  "flac_file_size"
    t.datetime "flac_updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "completed",    default: false, null: false
    t.datetime "completed_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "track_orders", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "track_id"
    t.decimal  "price"
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
    t.string   "name",                              null: false
    t.integer  "track_number"
    t.string   "sample_url"
    t.decimal  "price",               default: 2.0, null: false
    t.string   "track_isrc"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "mp3_file_name"
    t.string   "mp3_content_type"
    t.integer  "mp3_file_size"
    t.datetime "mp3_updated_at"
    t.string   "alac_file_name"
    t.string   "alac_content_type"
    t.integer  "alac_file_size"
    t.datetime "alac_updated_at"
    t.string   "aac_file_name"
    t.string   "aac_content_type"
    t.integer  "aac_file_size"
    t.datetime "aac_updated_at"
    t.string   "ogg_file_name"
    t.string   "ogg_content_type"
    t.integer  "ogg_file_size"
    t.datetime "ogg_updated_at"
    t.string   "flac_file_name"
    t.string   "flac_content_type"
    t.integer  "flac_file_size"
    t.datetime "flac_updated_at"
    t.string   "sample_file_name"
    t.string   "sample_content_type"
    t.integer  "sample_file_size"
    t.datetime "sample_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                          null: false
    t.string   "given_name"
    t.string   "family_name"
    t.string   "address_one"
    t.string   "address_two"
    t.string   "address_city"
    t.string   "address_country"
    t.string   "password_hash"
    t.boolean  "email_confirmed", default: true, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

end
