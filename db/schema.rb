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

ActiveRecord::Schema.define(version: 20170913064517) do

  create_table "brands", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.index ["name"], name: "index_brands_on_name", unique: true, using: :btree
  end

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "addressline1"
    t.string "addressline2"
    t.string "city"
    t.string "zipcode"
    t.string "state"
    t.string "aws_api_key"
    t.string "aws_api_secretkey"
    t.string "aws_assoicate_tag"
    t.string "mws_api_key"
    t.index ["name"], name: "index_companies_on_name", unique: true, using: :btree
  end

  create_table "product_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.index ["name"], name: "index_product_groups_on_name", unique: true, using: :btree
  end

  create_table "product_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.index ["name"], name: "index_product_types_on_name", unique: true, using: :btree
  end

  create_table "raked_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.index ["name"], name: "index_raked_categories_on_name", unique: true, using: :btree
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true, using: :btree
  end

  create_table "skynet_id_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
  end

  create_table "skynet_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.index ["name"], name: "index_skynet_statuses_on_name", unique: true, using: :btree
  end

  create_table "skynets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "task_id"
    t.string   "inputfileurl"
    t.string   "inputfilename"
    t.string   "idheadername",      default: "ID"
    t.string   "costheadername",    default: "COST"
    t.string   "skuheadername",     default: "SKU"
    t.boolean  "getestimatesales",  default: true
    t.boolean  "getisamazonsale",   default: true
    t.string   "webhookprogress"
    t.integer  "user_id"
    t.integer  "vendor_id"
    t.integer  "skynet_id_type_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "outputfileurl"
    t.string   "statusmessage"
    t.integer  "skynet_status_id"
    t.index ["inputfileurl"], name: "index_skynets_on_inputfileurl", unique: true, using: :btree
    t.index ["skynet_id_type_id"], name: "index_skynets_on_skynet_id_type_id", using: :btree
    t.index ["skynet_status_id"], name: "index_skynets_on_skynet_status_id", using: :btree
    t.index ["task_id"], name: "index_skynets_on_task_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_skynets_on_user_id", using: :btree
    t.index ["vendor_id"], name: "index_skynets_on_vendor_id", using: :btree
  end

  create_table "subscriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "subscriptionid"
    t.integer "amount"
    t.string  "interval"
    t.integer "created"
    t.index ["subscriptionid"], name: "index_subscriptions_on_subscriptionid", unique: true, using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "active",                 default: true
    t.integer  "role_id"
    t.integer  "company_id"
    t.string   "subscription_id"
    t.index ["company_id"], name: "index_users_on_company_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["role_id"], name: "index_users_on_role_id", using: :btree
  end

  create_table "vendor_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_vendor_categories_on_name", unique: true, using: :btree
  end

  create_table "vendorasins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "asin"
    t.integer  "brand_id"
    t.string   "name"
    t.integer  "salesrank"
    t.integer  "packagequantity"
    t.decimal  "buyboxprice",        precision: 10, default: 0
    t.decimal  "referenceoffer",     precision: 10
    t.string   "referenceoffertype"
    t.decimal  "fbafee",             precision: 10, default: 0
    t.decimal  "storagefee",         precision: 10, default: 0
    t.decimal  "variableclosingfee", precision: 10, default: 0
    t.decimal  "commissionpct",      precision: 10, default: 0
    t.decimal  "commissiionfee",     precision: 10, default: 0
    t.decimal  "inboundshipping",    precision: 10
    t.decimal  "salespermonth",      precision: 10, default: 0
    t.integer  "totaloffers",                       default: 0
    t.integer  "fbaoffers",                         default: 0
    t.integer  "fbmoffers",                         default: 0
    t.decimal  "lowestfbaoffer",     precision: 10, default: 0
    t.decimal  "lowestfbmoffer",     precision: 10, default: 0
    t.boolean  "isbuyboxfba",                       default: false
    t.integer  "product_type_id"
    t.integer  "ranked_category_id"
    t.decimal  "weight",             precision: 10
    t.decimal  "length",             precision: 10
    t.decimal  "width",              precision: 10
    t.decimal  "height",             precision: 10
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "product_groups_id"
    t.decimal  "packagewidth",       precision: 10
    t.decimal  "packageheight",      precision: 10
    t.decimal  "packagelength",      precision: 10
    t.decimal  "packageweight",      precision: 10
    t.string   "notes"
    t.decimal  "review",             precision: 10, default: 0
    t.integer  "numreview",                         default: 0
    t.boolean  "amazonoffer",                       default: false
    t.decimal  "totalfbafee",        precision: 10, default: 0
    t.string   "mpn",                               default: ""
    t.string   "ean",                               default: ""
    t.string   "upc",                               default: ""
    t.boolean  "invalidid",                         default: false
    t.index ["asin"], name: "index_vendorasins_on_asin", unique: true, using: :btree
    t.index ["brand_id"], name: "index_vendorasins_on_brand_id", using: :btree
    t.index ["product_groups_id"], name: "index_vendorasins_on_product_groups_id", using: :btree
    t.index ["product_type_id"], name: "index_vendorasins_on_product_type_id", using: :btree
    t.index ["ranked_category_id"], name: "index_vendorasins_on_ranked_category_id", using: :btree
  end

  create_table "vendoritems", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.decimal  "cost",          precision: 10, default: 0
    t.string   "name"
    t.integer  "vendorasin_id"
    t.integer  "vendor_id"
    t.string   "asin"
    t.string   "upc"
    t.string   "isbn"
    t.string   "ean"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "vendorsku",                    default: ""
    t.integer  "packcount",                    default: 1
    t.index ["vendor_id"], name: "index_vendoritems_on_vendor_id", using: :btree
    t.index ["vendorasin_id"], name: "index_vendoritems_on_vendorasin_id", using: :btree
  end

  create_table "vendors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.string  "addressline1"
    t.string  "addressline2"
    t.string  "city"
    t.string  "zipcode"
    t.string  "state"
    t.string  "account_number"
    t.string  "contact"
    t.string  "title"
    t.string  "phone"
    t.string  "email"
    t.string  "website"
    t.boolean "dropship"
    t.boolean "crossdock"
    t.string  "login"
    t.string  "password"
    t.string  "ref_name"
    t.string  "ref_title"
    t.string  "ref_phone"
    t.string  "ref_email"
    t.string  "ref_fax"
    t.string  "ship_fba"
    t.string  "ship_ltl"
    t.string  "sticker_unit"
    t.string  "ship_tier"
    t.string  "tier_price"
    t.string  "cc_tran"
    t.integer "leadtime",           default: 14
    t.integer "user_id"
    t.integer "vendor_category_id"
    t.index ["name"], name: "index_vendors_on_name", unique: true, using: :btree
    t.index ["user_id"], name: "index_vendors_on_user_id", using: :btree
    t.index ["vendor_category_id"], name: "index_vendors_on_vendor_category_id", using: :btree
  end

end
