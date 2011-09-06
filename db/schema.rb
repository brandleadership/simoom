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

ActiveRecord::Schema.define(:version => 20110906132050) do

  create_table "projects", :force => true do |t|
    t.integer  "basecamp_id"
    t.string   "name"
    t.string   "p_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "todo_items", :force => true do |t|
    t.string   "name"
    t.integer  "basecamp_id"
    t.integer  "todo_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "todo_lists", :force => true do |t|
    t.integer  "basecamp_id"
    t.integer  "project_id"
    t.integer  "estimate"
    t.string   "name"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "week_todo_items", :id => false, :force => true do |t|
    t.integer  "week_id"
    t.integer  "todo_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weeks", :force => true do |t|
    t.integer  "nr"
    t.integer  "available_hours"
    t.boolean  "done"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
