# == Schema Information
#
# Table name: vendoritems
#
#  id            :integer          not null, primary key
#  cost          :decimal(10, )    default(0)
#  name          :string(255)
#  vendorasin_id :integer
#  vendor_id     :integer
#  asin          :string(255)
#  upc           :string(255)
#  isbn          :string(255)
#  ean           :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  vendorsku     :string(255)      default("")
#  packcount     :integer          default(1)
#
# Indexes
#
#  index_vendoritems_on_vendor_id      (vendor_id)
#  index_vendoritems_on_vendorasin_id  (vendorasin_id)
#

require 'test_helper'

class VendoritemsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
