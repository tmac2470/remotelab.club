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

ActiveRecord::Schema.define(version: 20160307041348) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gateways", force: true do |t|
    t.boolean  "synched"
    t.string   "password"
    t.string   "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gateway_hash"
    t.string   "status"
  end

  create_table "laboratories", force: true do |t|
    t.string   "title"
    t.integer  "laboratory_type"
    t.integer  "user_id"
    t.text     "description"
    t.string   "pdf_file"
    t.text     "ui_json"
    t.string   "laboratory_hash"
    t.boolean  "published"
    t.string   "default"
    t.string   "false"
    t.string   "password"
    t.string   "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "laboratories_things", id: false, force: true do |t|
    t.integer "laboratory_id", null: false
    t.integer "thing_id",      null: false
  end

  create_table "rigs", force: true do |t|
    t.string   "title"
    t.integer  "rig_type"
    t.integer  "user_id"
    t.text     "description"
    t.string   "pdf_file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "ui_json"
    t.string   "rig_hash"
    t.boolean  "synced",      default: false
    t.boolean  "published",   default: false
    t.string   "password"
  end

  create_table "slave_data", force: true do |t|
    t.integer  "slave_module_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pin"
  end

  create_table "slave_modules", force: true do |t|
    t.integer  "rig_id"
    t.integer  "s_type"
    t.integer  "s_addr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slave_widgets", force: true do |t|
    t.integer  "rig_id"
    t.text     "settings"
    t.boolean  "enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "thing_data", force: true do |t|
    t.integer  "thing_id"
    t.text     "data"
    t.string   "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "thing_widgets", force: true do |t|
    t.integer  "gateway_id"
    t.text     "settings"
    t.boolean  "enabled"
    t.string   "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "things", force: true do |t|
    t.integer  "gateway_id"
    t.integer  "thing_type"
    t.integer  "thing_addr"
    t.string   "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "laboratory_id"
    t.string   "status"
    t.string   "thing_hash"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
