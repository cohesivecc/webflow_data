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

ActiveRecord::Schema[8.0].define(version: 2017_05_24_162725) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pg_catalog.plpgsql"

  create_table "webflow_data_collections", force: :cascade do |t|
    t.string "webflow_id"
    t.jsonb "webflow_data"
    t.date "last_updated"
    t.date "created_on"
    t.string "name"
    t.string "slug"
    t.string "singular_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["webflow_data"], name: "index_webflow_data_collections_on_webflow_data", using: :gin
  end

  create_table "webflow_data_fields", force: :cascade do |t|
    t.string "webflow_id"
    t.string "slug"
    t.string "name"
    t.boolean "required"
    t.hstore "validations"
    t.string "field_type"
    t.integer "collection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_webflow_data_fields_on_collection_id"
  end

  create_table "webflow_data_items", force: :cascade do |t|
    t.boolean "_archived"
    t.boolean "_draft"
    t.string "webflow_id"
    t.string "webflow_collection_id"
    t.string "name"
    t.string "slug"
    t.date "updated_on"
    t.date "created_on"
    t.date "published_on"
    t.date "updated_by"
    t.date "created_by"
    t.date "published_by"
    t.string "collection_type"
    t.jsonb "webflow_data"
    t.integer "collection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["collection_id"], name: "index_webflow_data_items_on_collection_id"
    t.index ["webflow_data"], name: "index_webflow_data_items_on_webflow_data", using: :gin
  end

  add_foreign_key "webflow_data_fields", "webflow_data_collections", column: "collection_id"
  add_foreign_key "webflow_data_items", "webflow_data_collections", column: "collection_id"
end
