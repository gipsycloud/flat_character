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

ActiveRecord::Schema[7.0].define(version: 2025_03_17_034456) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "admin_email"
    t.string "admin_name"
    t.string "admin_phone_number"
    t.string "admin_roles"
    t.string "status"
    t.datetime "last_login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "name"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "article_title"
    t.string "article_content"
    t.string "article_image"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "homes", force: :cascade do |t|
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string "memberName"
    t.string "email"
    t.string "phoneNumber"
    t.string "memberAddress"
    t.datetime "joinDate"
    t.datetime "lastLogin"
    t.string "memberType"
    t.bigint "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.index ["room_id"], name: "index_members_on_room_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "card_holder_name"
    t.string "card_number"
    t.string "cvc"
    t.string "billing_address"
    t.bigint "user_id", null: false
    t.string "exp_year"
    t.string "exp_month"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "plan_name"
    t.string "plan_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "post_title"
    t.string "post_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "properties", force: :cascade do |t|
    t.bigint "room_id"
    t.bigint "user_id"
    t.string "cupon_code"
    t.string "discount_amount"
    t.string "tax"
    t.string "phone_number"
    t.string "room_price"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "total_amount"
    t.string "guest_count"
    t.string "day_count"
    t.string "service_fee"
    t.string "cleaning_fee"
    t.string "rent_service"
    t.index ["room_id"], name: "index_properties_on_room_id"
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "room_images", force: :cascade do |t|
    t.integer "room_id"
    t.string "room_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "roomType"
    t.integer "maxPersons"
    t.string "roomPrice"
    t.string "gender"
    t.integer "roomNumber"
    t.text "details"
    t.datetime "startDate"
    t.datetime "endDate"
    t.string "floor"
    t.string "address"
    t.string "room_status"
    t.string "feedback"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "image"
    t.string "slug"
    t.float "latitude"
    t.float "longitude"
    t.index ["slug"], name: "index_rooms_on_slug", unique: true
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "notify_when_added_to_room", default: true
  end

  create_table "upgrades", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "plan_id"
    t.datetime "startDate"
    t.datetime "endDate"
    t.integer "duration"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_upgrades_on_plan_id"
    t.index ["user_id"], name: "index_upgrades_on_user_id"
  end

  create_table "user_infos", force: :cascade do |t|
    t.bigint "user_id"
    t.string "job_type"
    t.text "details"
    t.string "plan"
    t.string "hobby", default: [], array: true
    t.string "favourite"
    t.string "facebook_link"
    t.string "instagram"
    t.string "twitter"
    t.string "linkedin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "manner_categories", default: [], array: true
    t.index ["user_id"], name: "index_user_infos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "user_name"
    t.string "phone_number"
    t.string "address"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.integer "pin"
    t.datetime "pin_sent_at"
    t.boolean "verified", default: false
    t.string "avatar"
    t.boolean "notify_when_added_to_room", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "articles", "users"
  add_foreign_key "members", "rooms"
  add_foreign_key "payments", "users"
  add_foreign_key "properties", "rooms"
  add_foreign_key "properties", "users"
  add_foreign_key "rooms", "users"
  add_foreign_key "upgrades", "plans"
  add_foreign_key "upgrades", "users"
  add_foreign_key "user_infos", "users"
end
