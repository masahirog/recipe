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

ActiveRecord::Schema[7.1].define(version: 2025_05_17_002533) do
  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
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

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "materials", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "vendor_id"
    t.string "name", null: false
    t.integer "category", null: false
    t.string "recipe_unit", null: false
    t.float "recipe_unit_price", default: 0.0, null: false
    t.text "memo"
    t.boolean "unused_flag", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "recipe_unit_gram_quantity"
  end

  create_table "menu_materials", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "menu_id"
    t.bigint "material_id"
    t.float "amount_used", default: 0.0, null: false
    t.string "preparation"
    t.integer "row_order", default: 0, null: false
    t.float "gram_quantity"
    t.float "calorie", default: 0.0, null: false
    t.float "protein", default: 0.0, null: false
    t.float "lipid", default: 0.0, null: false
    t.float "carbohydrate", default: 0.0, null: false
    t.float "salt", default: 0.0, null: false
    t.integer "source_group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "cost_price", default: 0.0, null: false
    t.index ["material_id"], name: "index_menu_materials_on_material_id"
    t.index ["menu_id"], name: "index_menu_materials_on_menu_id"
  end

  create_table "menus", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "category", null: false
    t.text "cook_before"
    t.text "cook_on_the_day"
    t.float "cost_price", default: 0.0, null: false
    t.float "calorie", default: 0.0, null: false
    t.float "protein", default: 0.0, null: false
    t.float "lipid", default: 0.0, null: false
    t.float "carbohydrate", default: 0.0, null: false
    t.float "salt", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_menus_count", default: 0, null: false
    t.integer "menu_materials_count", default: 0, null: false
  end

  create_table "product_menus", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "menu_id"
    t.integer "row_order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_product_menus_on_menu_id"
    t.index ["product_id"], name: "index_product_menus_on_product_id"
  end

  create_table "products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "food_label_name", null: false
    t.integer "sell_price", default: 0, null: false
    t.float "cost_price", default: 0.0, null: false
    t.integer "category", null: false
    t.text "introduction"
    t.text "memo"
    t.text "serving_infomation"
    t.text "raw_materials_food_contents"
    t.text "raw_materials_additive_contents"
    t.float "calorie", default: 0.0, null: false
    t.float "protein", default: 0.0, null: false
    t.float "lipid", default: 0.0, null: false
    t.float "carbohydrate", default: 0.0, null: false
    t.float "salt", default: 0.0, null: false
    t.string "how_to_save"
    t.string "sales_unit_amount"
    t.boolean "unused_flag", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_menus_count", default: 0, null: false
    t.index ["name"], name: "index_products_on_name", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
