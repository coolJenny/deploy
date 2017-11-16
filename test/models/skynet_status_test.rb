# == Schema Information
#
# Table name: skynet_statuses
#
#  id   :integer          not null, primary key
#  name :string(255)
#
# Indexes
#
#  index_skynet_statuses_on_name  (name) UNIQUE
#

require 'test_helper'

class SkynetStatusTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
