# == Schema Information
#
# Table name: roles
#
#  id   :integer          not null, primary key
#  name :string(255)      not null
#
# Indexes
#
#  index_roles_on_name  (name) UNIQUE
#

require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
