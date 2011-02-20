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

ActiveRecord::Schema.define(:version => 20110220144811) do

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "shortname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "top_stories_endpoint"
    t.string   "search_endpoint"
    t.string   "story_details_endpoint"
  end

  create_table "stories", :force => true do |t|
    t.integer  "site_id"
    t.string   "title"
    t.string   "url"
    t.string   "url_hash"
    t.string   "site_name"
    t.integer  "digg",        :default => 0
    t.integer  "reddit",      :default => 0
    t.integer  "tweetmeme",   :default => 0
    t.integer  "hn",          :default => 0
    t.integer  "facebook",    :default => 0
    t.integer  "total_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
