# == Schema Information
#
# Table name: raked_categories
#
#  id   :integer          not null, primary key
#  name :string(255)
#
# Indexes
#
#  index_raked_categories_on_name  (name) UNIQUE
#

require 'test_helper'

class RakedCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
