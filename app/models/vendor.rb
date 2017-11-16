# == Schema Information
#
# Table name: vendors
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  addressline1       :string(255)
#  addressline2       :string(255)
#  city               :string(255)
#  zipcode            :string(255)
#  state              :string(255)
#  account_number     :string(255)
#  contact            :string(255)
#  title              :string(255)
#  phone              :string(255)
#  email              :string(255)
#  website            :string(255)
#  dropship           :boolean
#  crossdock          :boolean
#  login              :string(255)
#  password           :string(255)
#  ref_name           :string(255)
#  ref_title          :string(255)
#  ref_phone          :string(255)
#  ref_email          :string(255)
#  ref_fax            :string(255)
#  ship_fba           :string(255)
#  ship_ltl           :string(255)
#  sticker_unit       :string(255)
#  ship_tier          :string(255)
#  tier_price         :string(255)
#  cc_tran            :string(255)
#  leadtime           :integer          default(14)
#  user_id            :integer
#  vendor_category_id :integer
#
# Indexes
#
#  index_vendors_on_name                (name) UNIQUE
#  index_vendors_on_user_id             (user_id)
#  index_vendors_on_vendor_category_id  (vendor_category_id)
#

class Vendor < ApplicationRecord
  belongs_to :user
  belongs_to :vendor_category
  has_many :skynets
  has_many  :vendoritem
  validates :name, presence: true, uniqueness: true
end
