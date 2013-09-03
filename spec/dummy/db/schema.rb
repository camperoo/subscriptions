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

ActiveRecord::Schema.define(version: 20130903231446) do

  create_table "subscriptions_customers", force: true do |t|
    t.string   "email"
    t.string   "description"
    t.decimal  "account_balance"
    t.string   "assigned_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions_groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions_invoices", force: true do |t|
    t.date     "invoice_start_date"
    t.date     "invoice_end_date"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions_invoices", ["customer_id"], name: "index_subscriptions_invoices_on_customer_id"

  create_table "subscriptions_line_items", force: true do |t|
    t.string   "description"
    t.decimal  "amount"
    t.date     "date_added"
    t.integer  "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions_line_items", ["invoice_id"], name: "index_subscriptions_line_items_on_invoice_id"

  create_table "subscriptions_payments", force: true do |t|
    t.integer  "customer_id"
    t.integer  "invoice_id"
    t.integer  "card_id"
    t.decimal  "amount"
    t.decimal  "fee"
    t.date     "date"
    t.string   "status"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions_payments", ["card_id"], name: "index_subscriptions_payments_on_card_id"
  add_index "subscriptions_payments", ["customer_id"], name: "index_subscriptions_payments_on_customer_id"
  add_index "subscriptions_payments", ["invoice_id"], name: "index_subscriptions_payments_on_invoice_id"

  create_table "subscriptions_plans", force: true do |t|
    t.string   "name"
    t.decimal  "amount"
    t.integer  "interval_quantity"
    t.string   "interval_units"
    t.integer  "trial_period_days"
    t.integer  "assigned_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions_plans", ["group_id"], name: "index_subscriptions_plans_on_group_id"

  create_table "subscriptions_subscriptions", force: true do |t|
    t.date     "start_date"
    t.integer  "plan_id"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions_subscriptions", ["customer_id"], name: "index_subscriptions_subscriptions_on_customer_id"
  add_index "subscriptions_subscriptions", ["plan_id"], name: "index_subscriptions_subscriptions_on_plan_id"

end