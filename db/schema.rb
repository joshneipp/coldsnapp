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

ActiveRecord::Schema.define(version: 2019_03_04_141847) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cached_forecasts", force: :cascade do |t|
    t.string "zip_code"
    t.text "low_temperatures"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.json "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "username"
    t.string "sms_number"
    t.string "sms_verification_code"
    t.datetime "sms_verification_sent_at"
    t.boolean "sms_verified", default: false
    t.datetime "next_forecast_check_time"
  end

end
