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

ActiveRecord::Schema.define(version: 20160520144531) do

  create_table "bill_services", force: :cascade do |t|
    t.integer  "quantity",   default: 0
    t.integer  "service_id"
    t.integer  "bill_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "bill_services", ["bill_id"], name: "index_bill_services_on_bill_id"
  add_index "bill_services", ["service_id"], name: "index_bill_services_on_service_id"

  create_table "bills", force: :cascade do |t|
    t.integer  "receipt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bills", ["receipt_id"], name: "index_bills_on_receipt_id"

  create_table "customer_types", force: :cascade do |t|
    t.string   "name"
    t.float    "discount",   default: 0.0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "identity_card"
    t.text     "address"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "type_id"
  end

  add_index "customers", ["type_id"], name: "index_customers_on_type_id"

  create_table "receipts", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "room_id"
    t.integer  "quantity",    default: 1
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "receipts", ["customer_id"], name: "index_receipts_on_customer_id"
  add_index "receipts", ["room_id"], name: "index_receipts_on_room_id"

  create_table "room_types", force: :cascade do |t|
    t.string   "name"
    t.decimal  "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.text     "annotation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "type_id"
  end

  add_index "rooms", ["type_id"], name: "index_rooms_on_type_id"

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.string   "unit"
    t.decimal  "price",      default: 0.0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
