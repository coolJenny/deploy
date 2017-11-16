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

require 'test_helper'

class VendorCategoriesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
