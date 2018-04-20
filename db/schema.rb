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

ActiveRecord::Schema.define(version: 20180420142336) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "compares", force: :cascade do |t|
    t.string "input"
    t.string "output"
    t.boolean "term_point"
    t.integer "ref_field_source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "operator"
  end

  create_table "dest_fields", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "input2s", force: :cascade do |t|
    t.string "in_object"
    t.string "in_food"
    t.string "in_place"
    t.integer "in_id"
    t.date "in_date"
    t.integer "in_amt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inputs", force: :cascade do |t|
    t.string "in_fruit_1"
    t.string "in_obj_2"
    t.string "in_city_3"
    t.string "in_time_4"
    t.string "in_id_5"
    t.string "in_date_6"
    t.string "in_amt_7"
    t.string "in_bruise_8"
    t.string "in_size_9"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "output2s", force: :cascade do |t|
    t.string "out_objshape"
    t.string "out_objcolor"
    t.string "out_foodcolorage"
    t.string "out_placesize"
    t.string "out_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "input_id"
  end

  create_table "outputs", force: :cascade do |t|
    t.string "out_color_1"
    t.string "out_shape_2"
    t.string "out_state_3"
    t.string "out_daytime_4"
    t.string "out_id_5"
    t.string "out_date_6"
    t.string "out_amt_7"
    t.integer "input_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ref_field_sources", force: :cascade do |t|
    t.string "name"
    t.integer "var_level"
    t.integer "dest_field_id"
    t.string "operator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
