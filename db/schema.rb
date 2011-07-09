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

ActiveRecord::Schema.define(:version => 20110814192117) do

  create_table "countries", :force => true do |t|
    t.string "country"
    t.string "abbrev",  :limit => 5
  end

  create_table "linkrequests", :id => false, :force => true do |t|
    t.string   "uuid",               :limit => 36,  :default => "0",   :null => false
    t.string   "organization_url",   :limit => 100
    t.boolean  "is_active",                         :default => false
    t.string   "comments"
    t.string   "email",              :limit => 100
    t.string   "mission"
    t.string   "organization_name",  :limit => 25
    t.string   "image_content_type"
    t.string   "image_file_name"
    t.string   "first_name",         :limit => 15
    t.string   "mi",                 :limit => 1
    t.string   "last_name",          :limit => 15
    t.string   "city",               :limit => 15
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "placed_at"
    t.integer  "state_id"
    t.string   "zip_code",           :limit => 12
    t.boolean  "approved",                          :default => false
    t.string   "remote_ip",          :limit => 45
    t.integer  "img_height"
    t.integer  "img_width"
    t.string   "user_id",            :limit => 40,  :default => "",    :null => false
  end

  add_index "linkrequests", ["uuid"], :name => "uuid_index"

  create_table "perspectives", :id => false, :force => true do |t|
    t.string   "comments"
    t.string   "email",      :limit => 50
    t.string   "alias",      :limit => 16
    t.datetime "created_at"
    t.datetime "placed_at"
    t.string   "machine_ip"
    t.boolean  "approved",                 :default => false
    t.string   "user_id",    :limit => 40, :default => "0",   :null => false
    t.string   "uuid",       :limit => 40, :default => "0",   :null => false
  end

  add_index "perspectives", ["uuid"], :name => "uuid_index"

  create_table "posts", :id => false, :force => true do |t|
    t.string "uuid", :limit => 36
    t.string "name", :limit => 36
  end

  create_table "signatures", :force => true do |t|
    t.string   "comments"
    t.string   "email",               :limit => 50
    t.string   "first_name",          :limit => 15
    t.string   "mi",                  :limit => 1
    t.string   "last_name",           :limit => 15
    t.string   "alias",               :limit => 16
    t.string   "address1",            :limit => 20
    t.string   "address2",            :limit => 20
    t.integer  "state_id"
    t.string   "postal_code",         :limit => 12
    t.string   "city",                :limit => 20
    t.integer  "country_id"
    t.boolean  "display_name",                      :default => false
    t.boolean  "signature_agreement",               :default => false
    t.datetime "created_at"
    t.datetime "placed_at"
    t.integer  "signature_number"
    t.boolean  "comments_approved"
    t.string   "YOB",                 :limit => 4
    t.integer  "tmp"
  end

  create_table "states", :force => true do |t|
    t.string "state"
    t.string "abbrev", :limit => 3
  end

  create_table "users", :id => false, :force => true do |t|
    t.string   "user_id",                   :limit => 36
    t.string   "login",                     :limit => 40,  :default => "",         :null => false
    t.string   "password",                  :limit => 40
    t.string   "email",                     :limit => 100, :default => "",         :null => false
    t.string   "first_name",                :limit => 16,  :default => "",         :null => false
    t.string   "MI",                        :limit => 1
    t.string   "last_name",                 :limit => 16,  :default => "",         :null => false
    t.string   "role",                      :limit => 8,   :default => "nonadmin", :null => false
    t.datetime "created_at"
    t.datetime "placed_at"
    t.string   "machine_ip"
    t.boolean  "approved",                                 :default => false
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
  end
  add_index "users", ["user_id"], :name => "user_id_index"
end
