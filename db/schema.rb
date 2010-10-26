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

ActiveRecord::Schema.define(:version => 20101026212011) do

  create_table "datanest_agro_dotations", :force => true do |t|
    t.string  "title",               :limit => 20
    t.string  "name",                :limit => 100
    t.string  "surname",             :limit => 100
    t.string  "company",             :limit => 200
    t.string  "ico",                 :limit => 20
    t.string  "address",             :limit => 500
    t.string  "zip",                 :limit => 10
    t.string  "city",                :limit => 50
    t.string  "region",              :limit => 50
    t.float   "requested_amount"
    t.float   "dotation_amount"
    t.string  "currency",            :limit => 5
    t.integer "year"
    t.string  "purpose",             :limit => 500
    t.string  "income_number",       :limit => 50
    t.string  "note",                :limit => 500
    t.string  "paragraph",           :limit => 50
    t.date    "commitee_meeting_at"
    t.date    "requested_at"
    t.date    "request_received_at"
    t.string  "document",            :limit => 500
  end

  create_table "datanest_building_dotations", :force => true do |t|
    t.string  "company",                      :limit => 100
    t.string  "ico",                          :limit => 20
    t.string  "name",                         :limit => 100
    t.string  "surname",                      :limit => 100
    t.string  "city",                         :limit => 50
    t.string  "district",                     :limit => 100
    t.string  "county",                       :limit => 100
    t.float   "requested_amount"
    t.float   "assigned_amount"
    t.float   "project_value"
    t.string  "currency",                     :limit => 5
    t.string  "purpose",                      :limit => 500
    t.string  "dotation_type",                :limit => 200
    t.string  "note",                         :limit => 500
    t.integer "year"
    t.string  "dotation_provider",            :limit => 200
    t.integer "apartment_count"
    t.float   "duct_dotation_amount"
    t.float   "sewage_dotation_amount"
    t.float   "electrical_dotation_amount"
    t.float   "road_dotation_amount"
    t.float   "gas_pipeline_dotation_amount"
  end

  create_table "datanest_consolidations", :force => true do |t|
    t.string "company",      :limit => 200
    t.string "ico",          :limit => 20
    t.string "title",        :limit => 20
    t.string "name",         :limit => 100
    t.string "surname",      :limit => 100
    t.string "city",         :limit => 50
    t.string "name2",        :limit => 100
    t.float  "amount"
    t.string "currency",     :limit => 5
    t.string "note",         :limit => 500
    t.date   "updated_at"
    t.string "legal_form",   :limit => 50
    t.string "asset_number"
    t.string "psc",          :limit => 10
    t.string "surname2",     :limit => 100
    t.string "name3",        :limit => 100
    t.string "surname3",     :limit => 100
  end

  create_table "datanest_culture_dotations", :force => true do |t|
    t.string  "title",              :limit => 40
    t.string  "name",               :limit => 100
    t.string  "surname",            :limit => 100
    t.string  "company",            :limit => 200
    t.string  "ico",                :limit => 20
    t.string  "address",            :limit => 200
    t.string  "city",               :limit => 100
    t.string  "zip",                :limit => 10
    t.string  "district",           :limit => 50
    t.string  "county",             :limit => 50
    t.float   "dissaving"
    t.string  "currency",           :limit => 5
    t.float   "budget"
    t.string  "purpose",            :limit => 500
    t.string  "dotation_provider",  :limit => 200
    t.integer "year"
    t.string  "note",               :limit => 500
    t.string  "additional_note",    :limit => 500
    t.date    "contract_signed_at"
  end

  create_table "datanest_eurofonds", :force => true do |t|
    t.string  "title",                  :limit => 50
    t.string  "name",                   :limit => 100
    t.string  "surname",                :limit => 100
    t.string  "company",                :limit => 200
    t.string  "ico",                    :limit => 50
    t.string  "address",                :limit => 200
    t.string  "city",                   :limit => 100
    t.string  "zip",                    :limit => 40
    t.float   "requested_amount"
    t.float   "grant_amount"
    t.float   "accepted_amount"
    t.float   "own_resources_amount"
    t.float   "budget"
    t.string  "conditions_fullfilment", :limit => 500
    t.float   "paid_amount"
    t.float   "used_amount"
    t.string  "currency",               :limit => 5
    t.float   "receiver_share_amount"
    t.string  "dotation_provider",      :limit => 200
    t.string  "via",                    :limit => 200
    t.string  "resort",                 :limit => 200
    t.date    "commitee_meeting_at"
    t.date    "request_accepted_at"
    t.date    "decided_at"
    t.date    "granted_at"
    t.string  "registration_number",    :limit => 100
    t.string  "purpose",                :limit => 500
    t.string  "source",                 :limit => 500
    t.string  "program",                :limit => 500
    t.string  "dotation_type",          :limit => 500
    t.string  "fund_name",              :limit => 500
    t.string  "decision_number",        :limit => 100
    t.string  "region",                 :limit => 100
    t.string  "note",                   :limit => 500
    t.string  "additional_note",        :limit => 500
    t.integer "year"
    t.date    "project_start_at"
    t.date    "project_finish_at"
  end

  create_table "datanest_forgiven_tolls", :force => true do |t|
    t.string  "company",         :limit => 200
    t.string  "title",           :limit => 20
    t.string  "name",            :limit => 100
    t.string  "surname",         :limit => 100
    t.string  "ico",             :limit => 20
    t.string  "address",         :limit => 200
    t.string  "zip",             :limit => 10
    t.string  "city",            :limit => 100
    t.string  "paragraph",       :limit => 100
    t.float   "amount"
    t.string  "currency",        :limit => 5
    t.integer "year"
    t.string  "toll_office",     :limit => 100
    t.string  "note",            :limit => 500
    t.string  "additional_note", :limit => 500
  end

  create_table "datanest_organisation_addresses", :force => true do |t|
    t.string   "address",         :limit => 100
    t.integer  "organisation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "datanest_organisation_name_histories", :force => true do |t|
    t.string   "name",            :limit => 1000
    t.integer  "organisation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "datanest_organisations", :force => true do |t|
    t.string "name",           :limit => 1000
    t.string "ico",            :limit => 20
    t.string "address",        :limit => 200
    t.string "legal_form",     :limit => 200
    t.string "region",         :limit => 100
    t.string "date_start",     :limit => 20
    t.string "date_end",       :limit => 20
    t.text   "activity1"
    t.text   "activity2"
    t.string "account_sector", :limit => 200
    t.string "ownership",      :limit => 100
    t.string "size",           :limit => 100
    t.string "source_url",     :limit => 4000
  end

  add_index "datanest_organisations", ["name"], :name => "index_datanest_organisations_on_name_trgm"

  create_table "datanest_other_dotations", :force => true do |t|
    t.string  "title",            :limit => 20
    t.string  "name",             :limit => 50
    t.string  "surname",          :limit => 50
    t.string  "company",          :limit => 200
    t.string  "ico",              :limit => 20
    t.string  "address",          :limit => 200
    t.string  "mediator_company", :limit => 200
    t.float   "amount"
    t.string  "currency",         :limit => 5
    t.integer "year"
    t.float   "requested_amount"
    t.float   "utilized_amount"
    t.string  "purpose",          :limit => 500
    t.string  "note",             :limit => 500
    t.string  "provider",         :limit => 200
    t.string  "dotation_type",    :limit => 400
    t.string  "project_number",   :limit => 50
    t.string  "additional_note",  :limit => 500
    t.date    "accepted_at"
    t.date    "requested_at"
  end

  create_table "datanest_party_loans", :force => true do |t|
    t.string  "title",       :limit => 20
    t.string  "name",        :limit => 100
    t.string  "surname",     :limit => 100
    t.string  "company",     :limit => 200
    t.string  "ico",         :limit => 20
    t.string  "zip",         :limit => 10
    t.string  "city",        :limit => 100
    t.float   "amount"
    t.string  "currency",    :limit => 5
    t.string  "party",       :limit => 100
    t.integer "year"
    t.date    "received_at"
    t.date    "paid_at"
    t.date    "mature_at"
    t.string  "note",        :limit => 500
  end

  create_table "datanest_party_sponsors", :force => true do |t|
    t.string  "name",        :limit => 100
    t.string  "surname",     :limit => 100
    t.string  "title",       :limit => 20
    t.string  "company",     :limit => 100
    t.string  "ico",         :limit => 20
    t.float   "amount"
    t.string  "currency",    :limit => 3
    t.string  "address",     :limit => 500
    t.string  "zip",         :limit => 10
    t.string  "city",        :limit => 100
    t.string  "party",       :limit => 20
    t.integer "year"
    t.date    "received_at"
    t.string  "note",        :limit => 500
  end

  create_table "datanest_privatizations", :force => true do |t|
    t.string "privatized_comapny",         :limit => 100
    t.string "privatized_company_address", :limit => 100
    t.float  "estimate_amount"
    t.string "share",                      :limit => 50
    t.string "company",                    :limit => 100
    t.string "name",                       :limit => 100
    t.string "surname",                    :limit => 100
    t.string "title",                      :limit => 20
    t.string "address",                    :limit => 100
    t.float  "price_amount"
    t.string "currency",                   :limit => 5
    t.date   "sold_at"
    t.string "privatization_form",         :limit => 100
    t.string "seller",                     :limit => 100
    t.string "note",                       :limit => 500
  end

  create_table "datanest_procurements", :force => true do |t|
    t.integer "record_id"
    t.integer "year"
    t.integer "bulletin_id"
    t.string  "procurement_id",        :limit => 100
    t.integer "customer_ico"
    t.string  "customer_company_name", :limit => 1000
    t.string  "supplier_ico",          :limit => 20
    t.string  "supplier_company_name", :limit => 100
    t.string  "supplier_region",       :limit => 100
    t.text    "procurement_subject"
    t.float   "price_amount"
    t.string  "currency",              :limit => 50
    t.boolean "is_VAT_included"
    t.text    "customer_ico_evidence"
    t.text    "supplier_ico_evidence"
    t.text    "subject_evidence"
    t.text    "price_evidence"
    t.integer "procurement_type_id"
    t.integer "document_id"
    t.string  "source_url",            :limit => 1000
    t.string  "batch_record_code",     :limit => 200
  end

end
