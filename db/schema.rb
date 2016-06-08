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

ActiveRecord::Schema.define(version: 20160608075838) do

  create_table "bills", force: :cascade do |t|
    t.integer  "receipt_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "employee_id"
    t.integer  "customer_type"
  end

  add_index "bills", ["employee_id"], name: "index_bills_on_employee_id"
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
    t.string   "phone_number"
  end

  add_index "customers", ["type_id"], name: "index_customers_on_type_id"

  create_table "employees", force: :cascade do |t|
    t.string   "name"
    t.boolean  "gender",        default: false
    t.date     "date_of_birth"
    t.string   "phone"
    t.text     "address"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "receipt_services", force: :cascade do |t|
    t.integer "receipt_id"
    t.integer "service_id"
    t.integer "quantity",   default: 0
  end

  add_index "receipt_services", ["receipt_id"], name: "index_receipt_services_on_receipt_id"
  add_index "receipt_services", ["service_id"], name: "index_receipt_services_on_service_id"

  create_table "receipts", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "room_id"
    t.integer  "quantity",    default: 1
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "employee_id"
  end

  add_index "receipts", ["customer_id"], name: "index_receipts_on_customer_id"
  add_index "receipts", ["employee_id"], name: "index_receipts_on_employee_id"
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
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "type_id"
    t.integer  "max_quantity", default: 1
  end

  add_index "rooms", ["type_id"], name: "index_rooms_on_type_id"

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.string   "unit"
    t.decimal  "price",      default: 0.0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "statistics", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.integer  "customer_id"
    t.string   "role",                   default: ""
    t.integer  "employee_id"
  end

  add_index "users", ["customer_id"], name: "index_users_on_customer_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["employee_id"], name: "index_users_on_employee_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
