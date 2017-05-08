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

ActiveRecord::Schema.define(version: 20170508195510) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "webflow_data_collections", force: :cascade do |t|
    t.string   "webflow_id"
    t.jsonb    "webflow_data"
    t.date     "last_updated"
    t.date     "created_on"
    t.string   "name"
    t.string   "slug"
    t.string   "singular_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["webflow_data"], name: "index_webflow_data_collections_on_webflow_data", using: :gin
  end

  create_table "webflow_data_fields", force: :cascade do |t|
    t.string   "webflow_id"
    t.string   "slug"
    t.string   "name"
    t.boolean  "required"
    t.hstore   "validations"
    t.string   "field_type"
    t.integer  "webflow_data_collections_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["webflow_data_collections_id"], name: "index_webflow_data_fields_on_webflow_data_collections_id", using: :btree
  end

  create_table "webflow_data_items", force: :cascade do |t|
    t.boolean  "_archived"
    t.boolean  "_draft"
    t.string   "webflow_id"
    t.string   "webflow_collection_id"
    t.string   "name"
    t.string   "slug"
    t.date     "updated_on"
    t.date     "created_on"
    t.date     "published_on"
    t.date     "updated_by"
    t.date     "created_by"
    t.date     "published_by"
    t.string   "collection_type"
    t.jsonb    "webflow_data"
    t.integer  "webflow_data_collections_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["webflow_data"], name: "index_webflow_data_items_on_webflow_data", using: :gin
    t.index ["webflow_data_collections_id"], name: "index_webflow_data_items_on_webflow_data_collections_id", using: :btree
  end

  add_foreign_key "webflow_data_fields", "webflow_data_collections", column: "webflow_data_collections_id"
  add_foreign_key "webflow_data_items", "webflow_data_collections", column: "webflow_data_collections_id"
end
