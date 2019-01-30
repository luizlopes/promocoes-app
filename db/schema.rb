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

ActiveRecord::Schema.define(version: 2019_01_30_003639) do

  create_table "coupon_usages", force: :cascade do |t|
    t.integer "coupon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coupon_id"], name: "index_coupon_usages_on_coupon_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "promotion_id"
    t.integer "order_number"
    t.integer "status"
    t.index ["code"], name: "index_coupons_on_code", unique: true
    t.index ["promotion_id"], name: "index_coupons_on_promotion_id"
    t.index ["user_id"], name: "index_coupons_on_user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "product_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promotion_approvals", force: :cascade do |t|
    t.integer "promotion_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["promotion_id"], name: "index_promotion_approvals_on_promotion_id"
    t.index ["user_id"], name: "index_promotion_approvals_on_user_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.text "description"
    t.decimal "discount"
    t.string "name"
    t.integer "days"
    t.string "prefix"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.integer "creation_user_id"
    t.integer "approval_user_id"
    t.integer "product_id"
    t.integer "coupon_limit"
    t.datetime "activated_at"
    t.datetime "start_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
