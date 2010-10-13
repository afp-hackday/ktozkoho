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

ActiveRecord::Schema.define(:version => 20101011225430) do

  create_table "datanest_organisations", :force => true do |t|
    t.string  "name",    :limit => 100
    t.integer "ico"
    t.string  "address", :limit => 200
  end

  add_index "datanest_organisations", ["name", "address"], :name => "idx_ft_name_address"
  add_index "datanest_organisations", ["name"], :name => "index_datanest_organisations_on_name"

  create_table "datanest_party_sponsors", :force => true do |t|
    t.string  "name",     :limit => 100
    t.string  "surname",  :limit => 100
    t.string  "title",    :limit => 10
    t.string  "company",  :limit => 100
    t.integer "ico"
    t.float   "amount"
    t.string  "currency", :limit => 3
    t.string  "address",  :limit => 500
    t.string  "party",    :limit => 20
    t.integer "year"
  end

  add_index "datanest_party_sponsors", ["ico"], :name => "index_datanest_party_sponsors_on_ico"

end
