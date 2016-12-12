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

ActiveRecord::Schema.define(version: 20161207223759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feed_entries", force: :cascade do |t|
    t.string   "title"
    t.string   "host"
    t.string   "url"
    t.string   "author"
    t.text     "summary"
    t.integer  "feed_id"
    t.datetime "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id"], name: "index_feed_entries_on_feed_id", using: :btree
  end

  create_table "feeds", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.text     "description"
  end

  create_table "links", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "url"
    t.string   "title"
    t.string   "description"
    t.string   "group"
    t.string   "embed_code"
    t.string   "thumbnail"
    t.string   "feed_url"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", using: :btree
  end

  create_table "user_feed_tags", force: :cascade do |t|
    t.integer  "user_feed_id"
    t.integer  "tag_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["tag_id"], name: "index_user_feed_tags_on_tag_id", using: :btree
    t.index ["user_feed_id"], name: "index_user_feed_tags_on_user_feed_id", using: :btree
  end

  create_table "user_feeds", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "feed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id"], name: "index_user_feeds_on_feed_id", using: :btree
    t.index ["user_id"], name: "index_user_feeds_on_user_id", using: :btree
  end

  create_table "user_link_tags", force: :cascade do |t|
    t.integer  "user_link_id"
    t.integer  "tag_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["tag_id"], name: "index_user_link_tags_on_tag_id", using: :btree
    t.index ["user_link_id"], name: "index_user_link_tags_on_user_link_id", using: :btree
  end

  create_table "user_links", force: :cascade do |t|
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "link_id"
    t.index ["link_id"], name: "index_user_links_on_link_id", using: :btree
    t.index ["user_id"], name: "index_user_links_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "feed_entries", "feeds"
  add_foreign_key "user_feed_tags", "tags"
  add_foreign_key "user_feed_tags", "user_feeds"
  add_foreign_key "user_feeds", "feeds"
  add_foreign_key "user_feeds", "users"
  add_foreign_key "user_link_tags", "tags"
  add_foreign_key "user_link_tags", "user_links"
  add_foreign_key "user_links", "links"
  add_foreign_key "user_links", "users"
end
