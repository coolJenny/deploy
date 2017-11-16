# == Schema Information
#
# Table name: product_groups
#
#  id   :integer          not null, primary key
#  name :string(255)
#
# Indexes
#
#  index_product_groups_on_name  (name) UNIQUE
#

require 'test_helper'

class ProductGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
