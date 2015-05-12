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

ActiveRecord::Schema.define(version: 20150512134125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.string "remote_id"
    t.string "name"
    t.string "url"
    t.string "fare_url"
    t.string "timezone"
    t.string "language"
    t.string "phone"
    t.string "gtfs_endpoint"
  end

  add_index "agencies", ["remote_id"], name: "index_agencies_on_remote_id", using: :btree

  create_table "route_stops", force: :cascade do |t|
    t.integer "route_id", null: false
    t.integer "stop_id",  null: false
  end

  add_index "route_stops", ["stop_id", "route_id"], name: "index_route_stops_on_stop_id_and_route_id", unique: true, using: :btree

  create_table "routes", force: :cascade do |t|
    t.string   "remote_id"
    t.string   "short_name"
    t.string   "long_name"
    t.string   "description"
    t.string   "route_type"
    t.string   "url"
    t.string   "color"
    t.string   "text_color"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "agency_id"
  end

  add_index "routes", ["agency_id"], name: "index_routes_on_agency_id", using: :btree
  add_index "routes", ["remote_id", "agency_id"], name: "index_routes_on_remote_id_and_agency_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.integer  "agency_id"
    t.string   "remote_id"
    t.boolean  "monday",     default: false
    t.boolean  "tuesday",    default: false
    t.boolean  "wednesday",  default: false
    t.boolean  "thursday",   default: false
    t.boolean  "friday",     default: false
    t.boolean  "saturday",   default: false
    t.boolean  "sunday",     default: false
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "services", ["agency_id"], name: "index_services_on_agency_id", using: :btree

  create_table "stop_times", force: :cascade do |t|
    t.time     "arrival_time"
    t.time     "departure_time"
    t.string   "stop_sequence"
    t.string   "stop_headsign"
    t.integer  "pickup_type"
    t.integer  "drop_off_type"
    t.float    "shape_dist_traveled"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "agency_id"
    t.integer  "stop_id"
    t.integer  "trip_id"
  end

  add_index "stop_times", ["agency_id", "stop_id", "trip_id"], name: "index_stop_times_on_agency_id_and_stop_id_and_trip_id", using: :btree
  add_index "stop_times", ["agency_id"], name: "index_stop_times_on_agency_id", using: :btree
  add_index "stop_times", ["stop_id"], name: "index_stop_times_on_stop_id", using: :btree
  add_index "stop_times", ["trip_id"], name: "index_stop_times_on_trip_id", using: :btree

  create_table "stops", force: :cascade do |t|
    t.string   "remote_id"
    t.integer  "code"
    t.string   "name"
    t.string   "description"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "zone_id"
    t.string   "url"
    t.integer  "location_type"
    t.string   "parent_station"
    t.string   "timezone"
    t.integer  "wheelchair_boarding"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "agency_id"
  end

  add_index "stops", ["agency_id"], name: "index_stops_on_agency_id", using: :btree
  add_index "stops", ["remote_id", "agency_id"], name: "index_stops_on_remote_id_and_agency_id", using: :btree

  create_table "trips", force: :cascade do |t|
    t.string   "remote_id"
    t.integer  "service_id"
    t.string   "headsign"
    t.string   "short_name"
    t.integer  "direction_id"
    t.integer  "block_id"
    t.integer  "shape_id"
    t.integer  "wheelchair_accessible"
    t.integer  "bikes_allowed"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "agency_id"
    t.integer  "route_id"
  end

  add_index "trips", ["agency_id"], name: "index_trips_on_agency_id", using: :btree
  add_index "trips", ["remote_id", "agency_id"], name: "index_trips_on_remote_id_and_agency_id", using: :btree
  add_index "trips", ["route_id"], name: "index_trips_on_route_id", using: :btree

  add_foreign_key "route_stops", "routes"
  add_foreign_key "route_stops", "stops"
  add_foreign_key "routes", "agencies"
  add_foreign_key "services", "agencies"
  add_foreign_key "stop_times", "agencies"
  add_foreign_key "stop_times", "stops"
  add_foreign_key "stop_times", "trips"
  add_foreign_key "stops", "agencies"
  add_foreign_key "trips", "agencies"
  add_foreign_key "trips", "routes"
  add_foreign_key "trips", "services"
end
