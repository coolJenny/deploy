# == Schema Information
#
# Table name: product_types
#
#  id   :integer          not null, primary key
#  name :string(255)
#
# Indexes
#
#  index_product_types_on_name  (name) UNIQUE
#

require 'test_helper'

class ProductTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
