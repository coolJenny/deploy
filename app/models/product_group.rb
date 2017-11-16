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

class ProductGroup < ApplicationRecord
  has_many :vendorasin
end
