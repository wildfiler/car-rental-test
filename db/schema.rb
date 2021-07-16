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

ActiveRecord::Schema.define(version: 2021_07_16_161754) do

  create_table "cars", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "model", null: false
    t.string "color", null: false
    t.integer "price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.check_constraint "`price` > 0", name: "positive_price"
    t.check_constraint "char_length(`color`) > 0", name: "color_presence"
    t.check_constraint "char_length(`model`) > 0", name: "model_presence"
  end

  create_table "rents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "car_id"
    t.date "start_at"
    t.date "end_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_rents_on_car_id"
    t.check_constraint "`start_at` <= `end_at`", name: "correct_period"
  end

end
