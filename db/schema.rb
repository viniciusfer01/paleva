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

ActiveRecord::Schema[7.2].define(version: 2024_11_13_024707) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "beverages", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "is_alcoholic"
    t.integer "calories"
    t.integer "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["store_id"], name: "index_beverages_on_store_id"
  end

  create_table "dish_traits", force: :cascade do |t|
    t.integer "dish_id", null: false
    t.integer "trait_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_dish_traits_on_dish_id"
    t.index ["trait_id"], name: "index_dish_traits_on_trait_id"
  end

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "calories"
    t.integer "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["store_id"], name: "index_dishes_on_store_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.integer "menu_id", null: false
    t.integer "dish_id"
    t.integer "beverage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beverage_id"], name: "index_menu_items_on_beverage_id"
    t.index ["dish_id"], name: "index_menu_items_on_dish_id"
    t.index ["menu_id"], name: "index_menu_items_on_menu_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "portion_id", null: false
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["portion_id"], name: "index_order_items_on_portion_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone"
    t.string "email"
    t.string "cpf"
    t.integer "status", default: 0
    t.string "code", null: false
    t.integer "price", null: false
    t.integer "user_id"
    t.integer "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_orders_on_store_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "portions", force: :cascade do |t|
    t.string "description"
    t.integer "price"
    t.integer "beverage_id"
    t.integer "dish_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beverage_id"], name: "index_portions_on_beverage_id"
    t.index ["dish_id"], name: "index_portions_on_dish_id"
  end

  create_table "pre_registered_employees", force: :cascade do |t|
    t.string "email", null: false
    t.string "cpf", null: false
    t.boolean "used", default: false, null: false
    t.integer "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_pre_registered_employees_on_store_id"
  end

  create_table "store_menus", force: :cascade do |t|
    t.integer "store_id", null: false
    t.integer "menu_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_store_menus_on_menu_id"
    t.index ["store_id"], name: "index_store_menus_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "brand_name", null: false
    t.string "corporate_name", null: false
    t.string "cnpj", null: false
    t.string "address", null: false
    t.string "phone", null: false
    t.string "email", null: false
    t.string "schedule", null: false
    t.string "code", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stores_on_user_id"
  end

  create_table "traits", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_traits_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cpf", null: false
    t.string "name", null: false
    t.string "last_name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "beverages", "stores"
  add_foreign_key "dish_traits", "dishes"
  add_foreign_key "dish_traits", "traits"
  add_foreign_key "dishes", "stores"
  add_foreign_key "menu_items", "beverages"
  add_foreign_key "menu_items", "dishes"
  add_foreign_key "menu_items", "menus"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "portions"
  add_foreign_key "orders", "stores"
  add_foreign_key "orders", "users"
  add_foreign_key "portions", "beverages"
  add_foreign_key "portions", "dishes"
  add_foreign_key "pre_registered_employees", "stores"
  add_foreign_key "store_menus", "menus"
  add_foreign_key "store_menus", "stores"
  add_foreign_key "stores", "users"
end
