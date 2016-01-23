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

ActiveRecord::Schema.define(version: 20160122191212) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_products", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "merchants", force: :cascade do |t|
    t.string   "user_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "shipped",    default: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "status"
    t.datetime "order_time"
    t.string   "customer_name"
    t.string   "customer_email"
    t.integer  "customer_card_exp_month"
    t.integer  "customer_card_exp_year"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "street_address"
    t.integer  "zip_code"
    t.string   "state"
    t.integer  "security_code"
    t.integer  "card_number"
    t.string   "name_on_card"
    t.string   "city"
    t.integer  "billing_zip_code"
    t.string   "country"
    t.integer  "subtotal"
    t.integer  "shipping_cost"
    t.integer  "total_cost"
    t.integer  "shipping_method"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.integer  "merchant_id"
    t.string   "description"
    t.string   "photo_url"
    t.integer  "inventory"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "retire",      default: false
    t.string   "dimensions"
    t.integer  "weight"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.integer  "product_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
