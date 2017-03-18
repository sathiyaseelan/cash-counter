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

ActiveRecord::Schema.define(version: 20170318180149) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.boolean  "belongs_to_group"
    t.integer  "group_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["group_id"], name: "index_categories_on_group_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.text     "description"
    t.decimal  "amount"
    t.datetime "paid_on"
    t.integer  "paid_by_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "group_id"
    t.index ["group_id"], name: "index_expenses_on_group_id"
    t.index ["paid_by_id"], name: "index_expenses_on_paid_by_id"
  end

  create_table "expenses_categories", force: :cascade do |t|
    t.integer "expense_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_expenses_categories_on_category_id"
    t.index ["expense_id"], name: "index_expenses_categories_on_expense_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_groups_on_name"
  end

  create_table "members", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.string  "role",     default: "member"
    t.index ["group_id"], name: "index_members_on_group_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           default: "",     null: false
    t.string   "first_name",      default: "",     null: false
    t.string   "last_name",       default: "",     null: false
    t.string   "mobile",          default: "",     null: false
    t.string   "password_digest", default: "",     null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "role",            default: "user"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["first_name"], name: "index_users_on_first_name"
    t.index ["mobile"], name: "index_users_on_mobile", unique: true
  end

end
