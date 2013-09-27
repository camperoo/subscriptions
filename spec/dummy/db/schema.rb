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

ActiveRecord::Schema.define(version: 20130926223332) do

  create_table "subscriptions_credit_cards", force: true do |t|
    t.integer  "customer_id"
    t.string   "customer_profile_id"
    t.string   "customer_payment_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions_credit_cards", ["customer_id"], name: "index_subscriptions_credit_cards_on_customer_id"

  create_table "subscriptions_events", force: true do |t|
    t.integer  "payment_id"
    t.string   "user_identifier"
    t.string   "action"
    t.string   "amount"
    t.string   "event_type"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
    t.string   "code_text"
    t.text     "data"
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
    t.integer  "retries",            default: 0
    t.decimal  "amount"
    t.string   "status",             default: "pending"
    t.integer  "tenant_id"
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
    t.integer  "merchant_fee"
    t.decimal  "merchant_fee_percentage"
    t.date     "date"
    t.string   "status"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "amount"
  end

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

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
