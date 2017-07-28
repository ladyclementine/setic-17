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

ActiveRecord::Schema.define(version: 20170728142351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
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
    t.string   "name"
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "asaas_payments", force: :cascade do |t|
    t.string   "payment_asaas_id"
    t.string   "installment"
    t.string   "custumer_id"
    t.string   "boleto_url"
    t.string   "fatura_url"
    t.string   "status",              default: "PENDING"
    t.string   "description"
    t.datetime "client_payment_date"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "facilitator"
    t.integer  "limit"
    t.datetime "start"
    t.datetime "end"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "avatar"
  end

  create_table "hotels", force: :cascade do |t|
    t.string   "name"
    t.string   "extra_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lots", force: :cascade do |t|
    t.string   "name"
    t.integer  "number"
    t.integer  "limit"
    t.float    "value_not_federated"
    t.float    "value_federated"
    t.datetime "start_date",                                 null: false
    t.datetime "end_date",                                   null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.float    "value_not_federated_nohost"
    t.float    "value_federated_nohost"
    t.boolean  "nohost_active",              default: false
  end

  create_table "payments", force: :cascade do |t|
    t.string   "method"
    t.integer  "portions",         default: 1
    t.integer  "portion_paid",     default: 0
    t.float    "price"
    t.integer  "user_id"
    t.string   "user_asaas_id"
    t.string   "url_pagseguro"
    t.string   "status_pagseguro"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "host",             default: true
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_payments_on_deleted_at", using: :btree
    t.index ["user_id"], name: "index_payments_on_user_id", using: :btree
  end

  create_table "rooms", force: :cascade do |t|
    t.integer  "capacity"
    t.integer  "number"
    t.text     "extra_info"
    t.integer  "hotel_id"
    t.boolean  "air",        default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name",                                   array: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "subscribed_at"
    t.integer  "user_id"
    t.integer  "event_id"
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.string   "cpf"
    t.string   "general_register"
    t.date     "birthday"
    t.string   "gender"
    t.string   "phone"
    t.string   "federation"
    t.string   "junior_enterprise"
    t.string   "job"
    t.string   "university"
    t.boolean  "completed"
    t.text     "special_needs"
    t.boolean  "active",                 default: true
    t.integer  "lot_id"
    t.string   "avatar"
    t.datetime "paid_on"
    t.integer  "room_id"
    t.text     "address"
    t.string   "state"
    t.boolean  "transport_required",     default: false
    t.string   "transport_local"
    t.string   "city"
    t.string   "street"
    t.string   "cep"
    t.string   "phone_parents"
    t.string   "name_parents"
    t.integer  "federation_check",       default: 1
    t.datetime "deleted_at"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "terms_accept",           default: false
    t.boolean  "certificate",            default: false
    t.string   "email_face"
    t.boolean  "active_face",            default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", where: "(deleted_at IS NULL)", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "payments", "users"
end
