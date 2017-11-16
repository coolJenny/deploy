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

class Role < ApplicationRecord
  has_many :users
end
