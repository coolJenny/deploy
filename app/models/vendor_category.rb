# == Schema Information
#
# Table name: vendor_categories
#
#  id   :integer          not null, primary key
#  name :string(255)      not null
#
# Indexes
#
#  index_vendor_categories_on_name  (name) UNIQUE
#

class VendorCategory < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :vendors
end
