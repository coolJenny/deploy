# == Schema Information
#
# Table name: brands
#
#  id   :integer          not null, primary key
#  name :string(255)
#
# Indexes
#
#  index_brands_on_name  (name) UNIQUE
#

require 'test_helper'

class BrandTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
