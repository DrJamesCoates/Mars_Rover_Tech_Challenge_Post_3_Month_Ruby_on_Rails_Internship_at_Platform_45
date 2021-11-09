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

ActiveRecord::Schema.define(version: 2021_11_08_135109) do

  create_table "plateaus", force: :cascade do |t|
    t.string "name"
    t.integer "top_right_x_coordinate"
    t.integer "top_right_y_coordinate"
    t.boolean "explored"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rovers", force: :cascade do |t|
    t.string "name"
    t.string "heading"
    t.integer "x_coordinate"
    t.integer "y_coordinate"
    t.integer "plateau_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plateau_id"], name: "index_rovers_on_plateau_id"
  end

  add_foreign_key "rovers", "plateaus"
end
