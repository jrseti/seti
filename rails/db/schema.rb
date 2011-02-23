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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110223221403) do

  create_table "assignments", :force => true do |t|
    t.integer  "observation_range_id"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "observation_ranges", :force => true do |t|
    t.integer  "observation_id"
    t.decimal  "lo_mhz"
    t.decimal  "hi_mhz"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "url_part_list"
  end

  create_table "observations", :force => true do |t|
    t.date     "date"
    t.integer  "target_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "base_url"
  end

  create_table "targets", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "right_ascension", :precision => 15, :scale => 12
    t.decimal  "declination",     :precision => 15, :scale => 12
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "provider"
    t.string   "name"
    t.string   "role"
  end

end
